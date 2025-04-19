install.packages("glmnet")
library(glmnet)

df <- data(mtcars)
head(df)

target <- mtcars$mpg
features <- as.matrix(mtcars[, -which(names(mtcars) == "mpg")]) 

lasso<- glmnet(x = features, y = target, alpha = 1)

# Plot coefficient paths
plot(lasso, xvar = "lambda", label = TRUE)
cv_lasso <- cv.glmnet(x = features, y = target, alpha = 1)

# Plot cross-validation error
plot(cv_lasso)
# Best lambda value
best_lambda <- cv_lasso$lambda.min
print(paste("Best lambda:", best_lambda))coef(cv_lasso, s = "lambda.min")
coef(cv_lasso, s = "lambda.min")