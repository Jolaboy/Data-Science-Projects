rm(list = ls())

house.data <- read.csv("./datasets/kc_house_data.csv")
dim(house.data)
head(house.data)

# Check for missing values
colSums(is.na(house.data))

# Get rid of columns which are not relevant for the regression model
# We have removed lat, long because it is too granular but kept zip code
house.data <- subset(house.data, select = -c(id, date, lat, long))
head(house.data)

str(house.data)

# Pre-processing columns
unique(house.data$yr_renovated)

# Most of the homes have not been renovated
table(house.data$yr_renovated)

# My assumption is that the year of renovation does not hold much value but
# the fact that the home has been renovated does
house.data$yr_renovated <- ifelse(house.data$yr_renovated > 0, 1, 0)
table(house.data$yr_renovated)

library(ggplot2)

ggplot(house.data, aes(y = sqft_living)) + geom_boxplot() 
ggplot(house.data, aes(y = sqft_lot)) + geom_boxplot() 


install.packages("scales")
library(scales)

house.data <- within(house.data, {
  sqft_living <- squish(sqft_living, quantile(sqft_living, c(.05, .95)))
  sqft_lot <- squish(sqft_lot, quantile(sqft_lot, c(.05, .95)))
  sqft_above <- squish(sqft_above, quantile(sqft_above, c(.05, .95)))
  sqft_living15 <- squish(sqft_living15, quantile(sqft_living15, c(.05, .95)))
  sqft_lot15 <- squish(sqft_lot15, quantile(sqft_lot15, c(.05, .95)))
})

dim(house.data)

ggplot(house.data, aes(y = sqft_living)) + geom_boxplot(col = "orange") 

# Let's visualize and understand the relationships in this data
# Most homes are under 2.5 million though there are many outliers
ggplot(house.data, aes(x = price)) + 
  geom_histogram(col = "orange") + xlim(0, 2500000)

ggplot(house.data, aes(x = factor(waterfront), y = price)) + geom_boxplot() 

ggplot(house.data, aes(x = factor(condition), y = price)) + geom_boxplot() 

ggplot(house.data, aes(x = factor(view), y = price)) + geom_boxplot() 

ggplot(house.data, aes(x = sqft_living, y = price))+
  geom_point(col = "darkblue", size = 2.5)

ggplot(house.data, aes(x = yr_built, y = price))+
  geom_point(col = "darkgreen", size = 2.5)

ggplot(house.data, aes(x = bedrooms, y = price))+
  geom_point(col = "darkred", size = 2.5)

# Split the data into training data and test data
install.packages("caTools")
library(caTools)

set.seed(3)

mask <- sample.split(house.data$price, SplitRatio = 0.80)

training.data <- subset(house.data, mask == T)
test.data <- subset(house.data, mask == F)

dim(training.data)
dim(test.data)

# Fit the linear model (simple regression)

# Explain all the results in the summary (R2, p-values etc)
linear.model <- lm(price ~ bedrooms, data = training.data)
summary(linear.model)

linear.model <- lm(price ~ view, data = training.data)
summary(linear.model)

linear.model <- lm(price ~ sqft_living, data = training.data)
summary(linear.model)

# Linear models, multiple regression without interaction
linear.model <- lm(price ~ bedrooms + view, data = training.data)
summary(linear.model)

# Linear models, multiple regression with interaction
linear.model <- lm(price ~ bedrooms * view, data = training.data)
summary(linear.model)

# Adding more predictors
linear.model <- lm(price ~ bedrooms + view + waterfront, data = training.data)
summary(linear.model)

# Let's use all of the predictors
# Many of the predictors, such as yr_renovated, zipcode, sqft_lot do not
# have much predictive power
linear.model <- lm(price ~ ., data = training.data)
summary(linear.model)


### Residual against different measures
# Note:-  This is more conventional way to estimate the model performance is 
# to display the residual against different measures.

# https://data.library.virginia.edu/diagnostic-plots/

plot(linear.model)

prediction.prices <- predict(linear.model, test.data)
head(prediction.prices)

prediction.actual.data <- data.frame(predicted = prediction.prices, 
                                     actual = test.data$price)
tail(prediction.actual.data)

install.packages("MLmetrics")
library(MLmetrics)

install.packages("caret")
library(caret)

eval.stats <- data.frame(
  RMSE = RMSE(prediction.prices, test.data$price),
  Rsquare = R2(prediction.prices, test.data$price)
)
eval.stats

# Linear regression with cross-validation

train.control <- trainControl(method = "cv", number = 5)

linear.model.cv <- train(price~., data = training.data, 
                         method = "lm", trControl = train.control)

# The R2 has improved for the model
summary(linear.model.cv)

prediction.prices <- predict(linear.model.cv, test.data)
head(prediction.prices)

prediction.actual.data <- data.frame(predicted = prediction.prices, 
                                     actual = test.data$price)
tail(prediction.actual.data)

# The R2 for the test data has not improved much
eval.stats <- data.frame(
  RMSE = RMSE(prediction.prices, test.data$price),
  Rsquare = R2(prediction.prices, test.data$price)
)
eval.stats












