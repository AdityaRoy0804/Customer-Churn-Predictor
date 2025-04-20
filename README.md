# 🧠 Customer Churn Predictor App

This interactive Shiny web app predicts the likelihood of a customer churning (leaving a service) based on key factors such as age, credit score, activity status, and more. It is powered by a **Random Forest** machine learning model trained on a U.S. Bank Customer dataset.

The model is deployed at shinyapps.io cloud server ,thus making it accessible to anyone with internet access at any web browser.
🌐 **Live Demo**: https://aditya-kumar-roy.shinyapps.io/Churnpredictor/

---

## 📊 Features

- 🔮 **Churn Prediction** using a trained ML model (Random Forest)
- 📈 **Feature Importance Visualization** using `ggplot2`
- 🧠 **Automated Insights**: Textual explanations for churn risk (e.g., *Low balance*, *High age*, *Inactive member*)
- 🌙 **Dark Theme UI** for enhanced readability
- 💬 **Interactive Interface** with real-time predictions based on user input

---

## ⚙️ Technologies Used

- **R Language**
- **Shiny** – Web application framework
- **randomForest** – Machine learning model
- **caret** – Feature importance (via `varImp`)
- **ggplot2** – Visualization
- **shinythemes** – Styling and themes


## 🧩 How the Model Works

### 1. User Input
The user enters customer details via the interactive input fields on the app’s interface.

### 2. Churn Prediction
When the **"Predict Churn"** button is clicked, the Random Forest model makes a prediction on whether the customer is likely to churn.

### 3. Churn Risk Explanation
The app returns textual insights based on the input data — for example, indicating if a *high age*, *low balance*, or *non-active membership* may be contributing to higher churn risk.

### 4. Feature Importance Plot
The top 5 features influencing the churn prediction are visualized in a horizontal bar plot, generated via `ggplot2`.

---

---

## 🛠 How to Run Locally

1. **Install R and RStudio**

   - [Download R](https://cran.r-project.org/)
   - [Download RStudio](https://posit.co/download/rstudio-desktop/)

2. **Install Required Packages**

   Open RStudio and run:

   ```r
   install.packages(c("shiny", "shinythemes", "randomForest", "caret", "ggplot2", "pROC"))
   ```

3. **Clone the Repository**

   ```bash
   git clone https://github.com/AdityaRoy0804/Customer-Churn-Predictor.git
   ```

   Or [download the ZIP](https://github.com/AdityaRoy0804/Customer-Churn-Predictor/archive/refs/heads/main.zip) and extract it.

4. **Run the App**

   In RStudio, open the `app.R` file and run:

   ```r
   shiny::runApp("path/to/Customer-Churn-Predictor")
   ```

---

## 📬 Contact

For questions, suggestions, or contributions, feel free to open an issue or pull request on the [GitHub repository](https://github.com/AdityaRoy0804/Customer-Churn-Predictor).

To connect with the developer.
Gmail : roy97278@gmail.com

---






