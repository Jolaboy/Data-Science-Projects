rm(list = ls())

# Assumptions of the two-sample T-test
# https://en.wikipedia.org/wiki/Student%27s_t-test#Assumptions

# The means of the two populations being compared should follow normal 
# distributions. Under weak assumptions, this follows in large samples from 
# the central limit theorem, even when the distribution of observations in 
# each group is non-normal.
# If using Student's original definition of the t-test, the two populations 
# being compared should have the same variance. If the sample sizes in the 
# two groups being compared are equal, Student's original t-test is highly 
# robust to the presence of unequal variances.
# The data used to carry out the test should either be sampled independently 
# from the two populations being compared or be fully paired.

mall.data <- read.csv("./datasets/Mall_Customers.csv")
head(mall.data)

colnames(mall.data) <- c("CustomerID", 
                         "Gender", 
                         "Age", 
                         "AnnualIncome", 
                         "SpendingScore")
head(mall.data)

# This data is not normally distributed
ggplot(mall.data, aes(x = SpendingScore)) + 
  geom_histogram(col = "black", fill = "blue")

qqnorm(mall.data$SpendingScore)
qqline(mall.data$SpendingScore)

# p-value of the Shapiro-Wilk Test is greater than 0.05, the data is normal. 
# If it is below 0.05, the data significantly deviate from a normal distribution.
shapiro.test(mall.data$SpendingScore)

# Is the average spending score for males and females significantly different?
qplot(x = Gender, y = SpendingScore,
      geom = "boxplot", 
      data = mall.data,
      fill = I('blue'))

# Sample sizes are not the same
table(mall.data$Gender)

ggplot(mall.data, aes(x = Gender))+
  geom_bar(col = "black", fill = "blue")

male.score <- mall.data[mall.data$Gender == "Male", ]
head(male.score)

female.score <- mall.data[mall.data$Gender == "Female", ]
head(female.score)

# Sample the same number of elements from each group so sample sizes are now
# the same

install.packages("dplyr")
library(dplyr)
male.score <- sample_n(male.score, 80)
female.score <- sample_n(female.score, size = 80)

# Checking normality for each group (not normally distributed)
qqnorm(male.score$SpendingScore, pch = 20, col = "darkgreen")
qqline(male.score$SpendingScore, col = "red")

qqnorm(female.score$SpendingScore, pch = 20, col = "darkgreen")
qqline(female.score$SpendingScore, col = "red")

install.packages("car")
library(car)

# Null hypothesis: variances for the two groups are equal 
# Alternative hypothesis: variances for the two groups are NOT equal
# Since the p-value > 0.05 we can accept the null hypothesis and reject the
# alternative hypothesis
leveneTest(SpendingScore ~ factor(Gender), data = mall.data)

# Since the variances are equal then we can use the t-test to compare whether
# the average spending score differs significantly between males and females

# p-value > 0.05 accept the null hypothesis, there is no difference in the
# spending scores between males and females
t.test(male.score$SpendingScore, female.score$SpendingScore, var.equal = TRUE)

##################################################
# Let's try this with another dataset
##################################################

car.data <- read.csv("./datasets/CarPrice_Assignment.csv")
head(car.data)
dim(car.data)

car.data <- car.data[, c("carbody", "price")]
head(car.data)

car.data <- car.data[car.data$carbody == "sedan" | 
                       car.data$carbody == "hatchback", ]
head(car.data)


# Is the average price for sedans and hatchbacks significantly different?
library(ggplot2)

qplot(x = carbody, y = price,
      geom = "boxplot", 
      data = car.data,
      fill = I('blue'))


ggplot(car.data, aes(x = price)) + 
  geom_histogram(col = "black", fill = "blue")

qqnorm(car.data$price, pch = 20, col = "darkgreen")
qqline(car.data$price, col = "red")

# p-value of the Shapiro-Wilk Test is greater than 0.05, the data is normal. 
# If it is below 0.05, the data significantly deviate from a normal distribution.
shapiro.test(car.data$price)

sedan.prices <- car.data[car.data$carbody == "sedan", ]
head(sedan.prices)

hatchback.prices <- car.data[car.data$carbody == "hatchback", ]
head(hatchback.prices)

# Null hypothesis: variances for the two groups are equal 
# Alternative hypothesis: variances for the two groups are NOT equal
# Since the p-value < 0.05 we can reject the null hypothesis and accept the
# alternative hypothesis, the variances are unequal
leveneTest(price ~ factor(carbody), data = car.data)

# In statistics, Welch's t-test, or unequal variances t-test, is a two-sample 
# location test which is used to test the hypothesis that two populations have
# equal means. It is named for its creator, Bernard Lewis Welch, and is an 
# adaptation of Student's t-test,[1] and is more reliable when the two samples 
# have unequal variances and/or unequal sample sizes.
# https://en.wikipedia.org/wiki/Welch%27s_t-test
t.test(sedan.prices$price, hatchback.prices$price, var.equal = FALSE)





































