library(shiny)
library(randomForest)
library(ggplot2)
library(caret)
library(lattice)
library(shinythemes)

# Load model and importance
rf_model <- readRDS("rf_tuned.rds")
feature_importance <- varImp(rf_model)$importance
feature_importance$Feature <- rownames(feature_importance)
top_features <- feature_importance[order(-feature_importance$Overall), ][1:5, ]

ui <- fluidPage(
  theme = shinytheme("cyborg"),  # Dark theme
  
  tags$head(
    tags$style(HTML("
      h3 {
        text-align: center;
        font-weight: bold;
      }
    "))
  ),
  
  titlePanel("Customer Churn Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Geography", "Geography", choices = c("France", "Spain", "Germany")),
      selectInput("Gender", "Gender", choices = c("Male", "Female")),
      numericInput("Age", "Age", value = 40, min = 18, max = 100),
      numericInput("CreditScore", "Credit Score", value = 600, min = 300, max = 900),
      numericInput("Balance", "Balance", value = 100000),
      numericInput("EstimatedSalary", "Estimated Salary", value = 50000),
      numericInput("Tenure", "Tenure (years with bank)", value = 5, min = 0, max = 10),
      numericInput("NumOfProducts", "Number of Products", value = 1),
      selectInput("HasCrCard", "Has Credit Card?", choices = c(1, 0)),
      selectInput("IsActiveMember", "Is Active Member?", choices = c(1, 0)),
      
      actionButton("predictBtn", "Predict Churn", class = "btn-primary")
    ),
    
    mainPanel(
      h3("Prediction Result:"),
      verbatimTextOutput("prediction"),
      hr(),
      h3("Top Influencing Factors"),
      plotOutput("featurePlot"),
      hr(),
      h3("Churn Risk Insights"),
      verbatimTextOutput("reasoning")
    )
  )
)

server <- function(input, output) {
  
  user_data <- reactive({
    data.frame(
      CreditScore = input$CreditScore,
      Geography = factor(input$Geography, levels = c("France", "Germany", "Spain")),
      Gender = factor(input$Gender, levels = c("Female", "Male")),
      Age = input$Age,
      Tenure = input$Tenure,
      Balance = input$Balance,
      NumOfProducts = input$NumOfProducts,
      HasCrCard = as.numeric(input$HasCrCard),
      IsActiveMember = as.numeric(input$IsActiveMember),
      EstimatedSalary = input$EstimatedSalary
    )
  })
  
  get_reasoning <- function(data) {
    reasons <- c()
    
    if (data$Age > 40) {
      reasons <- c(reasons, "- Age is above 40, which is correlated with higher churn.")
    }
    if (data$Balance == 0) {
      reasons <- c(reasons, "- Account balance is zero, indicating low financial engagement.")
    }
    if (data$IsActiveMember == 0) {
      reasons <- c(reasons, "- Customer is not an active member.")
    }
    if (data$CreditScore < 600) {
      reasons <- c(reasons, "- Credit score is below 600, indicating potential credit risk.")
    }
    if (data$Geography == "Germany") {
      reasons <- c(reasons, "- Customers from Germany have a higher churn rate.")
    }
    if (data$NumOfProducts == 1) {
      reasons <- c(reasons, "- Only one product with the bank; less engagement increases churn likelihood.")
    }
    if (length(reasons) == 0) {
      reasons <- c("No strong churn risk indicators found based on the input.")
    }
    
    return(paste(reasons, collapse = "\n"))
  }
  
  observeEvent(input$predictBtn, {
    input_data <- user_data()
    pred <- predict(rf_model, newdata = input_data)
    
    output$prediction <- renderText({
      paste("Will the customer churn? →", ifelse(pred == 1, "Yes", "No"))
    })
    
    output$featurePlot <- renderPlot({
      ggplot(top_features, aes(x = reorder(Feature, Overall), y = Overall)) +
        geom_col(fill = "skyblue") +
        coord_flip() +
        labs(title = "Top 5 Influencing Features", x = "Feature", y = "Importance") +
        theme_minimal(base_size = 14) +
        theme(plot.title = element_text(hjust = 0.5, face = "bold"))
    })
    
    output$reasoning <- renderText({
      get_reasoning(input_data)
    })
  })
}

shinyApp(ui = ui, server = server)
