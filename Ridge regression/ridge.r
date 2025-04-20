# Step 1: Load the necessary libraries
library(glmnet)
library(Metrics)
library(caTools)

# Step 2: Load dataset and define independent and dependent variables
# For example, we'll use the built-in 'mtcars' dataset
data(mtcars)
X <- as.matrix(mtcars[, -1])  # Independent variables
y <- mtcars$mpg               # Dependent variable

# Step 3: Data preprocessing - split into train and test sets
set.seed(123)
split <- sample.split(y, SplitRatio = 0.7)
x_train <- X[split, ]
x_test <- X[!split, ]
y_train <- y[split]
y_test <- y[!split]

# Step 4: Implement Ridge Regression
# Define lambda values to try
lambdas <- 10^seq(3, -2, by = -0.1)

# Fit the ridge regression model (alpha = 0 for ridge)
ridge_regression <- glmnet(x_train, y_train, alpha = 0, lambda = lambdas, family = "gaussian")
print(ridge_regression)

# Step 5: Make predictions on the test set
# Select best lambda using cross-validation
cv_model <- cv.glmnet(x_train, y_train, alpha = 0, lambda = lambdas, family = "gaussian")
best_lambda <- cv_model$lambda.min
cat("Best lambda: ", best_lambda, "\n")

# Predict using the best lambda
predictions <- predict(ridge_regression, s = best_lambda, newx = x_test)

# Evaluate model
mse <- mse(y_test, predictions)
rmse <- rmse(y_test, predictions)

cat("Mean Squared Error: ", mse, "\n")
cat("Root Mean Squared Error: ", rmse, "\n")
