rm(list = ls())

# The one sample t test compares the mean of your sample data to a known value.

# For example, you might want to know how your sample mean compares to the 
# population mean. You should run a one sample t test when you don’t know the 
# population standard deviation or you have a small sample size. 

# Assumptions for the one-sample T-test

# Data is independent.
# Data is collected randomly.
# Although the parent population does not need to be normally distributed, 
# the distribution of the population of sample means is assumed to be normal

# The parametric test called t-test is useful for testing those samples whose 
# size is less than 30. The reason behind this is that if the size of the sample 
# is more than 30, then the distribution of the t-statistic and the normal 
# distribution will be indistinguishable.

# Note that sample size < 30
student.age.mean <- 20
student.age.sd <- 2
n.samples <- 25

student.age <- data.frame(age = rnorm(n.samples, 
                                      mean = student.age.mean, 
                                      sd = student.age.sd))
head(student.age)

ggplot(student.age, aes(x = age)) + 
  geom_histogram(col = "black", fill = "blue")

qqnorm(student.age$age)
qqline(student.age$age)

# Null hypothesis: Mean of student age == 30
# Alternative hypothesis: Mean of student age != 30
# Here based on p-value < 0.05 alpha level we can reject the null hypothesis
# and accept the alternative hypothesis
t.test(student.age$age, mu = 30)

# Null hypothesis: Mean of student age == 20
# Alternative hypothesis: Mean of student age != 20
# Here based on p-value > 0.05 alpha level we can accept the null hypothesis
# and reject the alternative hypothesis
t.test(student.age$age, mu = 20)

# Null hypothesis: Mean of student age == 18.5
# Alternative hypothesis: Mean of student age != 20
# Here based on p-value < 0.05 alpha level we can reject the null hypothesis
# and accept the alternative hypothesis
t.test(student.age$age, mu = 18.5)

# Let's try this on real world data

# The t-test is valid for samples from non-normal distributions for larger
# sample sizes

mall.data <- read.csv("./datasets/Mall_Customers.csv")
head(mall.data)
dim(mall.data)

colnames(mall.data) <- c("CustomerID", 
                         "Gender", 
                         "Age", 
                         "AnnualIncome", 
                         "SpendingScore")
head(mall.data)

str(mall.data)

# This data is not normally distributed
ggplot(mall.data, aes(x = SpendingScore)) + 
  geom_histogram(col = "black", fill = "blue")

qqnorm(mall.data$SpendingScore)
qqline(mall.data$SpendingScore)

# p-value of the Shapiro-Wilk Test is greater than 0.05, the data is normal. 
# If it is below 0.05, the data significantly deviate from a normal distribution.
shapiro.test(mall.data$SpendingScore)

mean(mall.data$SpendingScore)


# Null hypothesis: Mean  == 51
# Alternative hypothesis: Mean != 51
# Here based on p-value > 0.05 alpha level we can accept the null hypothesis
# and reject the alternative hypothesis
# Here we can accept the null hypothesis because the mu that we test against
# is within the range of the 99% confidence interval 
t.test(mall.data$SpendingScore, mu = 51, 
       alternative = "two.sided", conf.level = .99)

# Null hypothesis: Mean  == 55
# Alternative hypothesis: Mean != 55
# Here based on p-value < 0.05 alpha level we can reject the null hypothesis
# and accept the alternative hypothesis
t.test(mall.data$SpendingScore, mu = 55, 
       alternative = "two.sided", conf.level = .95)


# Null hypothesis: Mean is not greater than 55
# Alternative hypothesis: Mean is greater than 55
# Here based on p-value > 0.05 alpha level we can accept the null hypothesis
# and reject the alternative hypothesis
t.test(mall.data$SpendingScore, mu = 55, 
       alternative = "greater")

# Null hypothesis: Mean is not less than 55
# Alternative hypothesis: Mean is less than 55
# Here based on p-value < 0.05 alpha level we can reject the null hypothesis
# and accept the alternative hypothesis
t.test(mall.data$SpendingScore, mu = 55, 
       alternative = "less")










