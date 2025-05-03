rm(list = ls())

# Assumptions of ANOVA
# Each group sample is drawn from a normally distributed population
# All populations have a common variance
# All samples are drawn independently of each other
# Within each sample, the observations are sampled randomly and independently 
# of each other
# Factor effects are additive

loan.data <- read.csv("./datasets/data_loan.csv")
head(loan.data)

# 3 categories for degree, suitable for ANOVA analysis but not for T-test
unique(loan.data$Degree)

# Is the average income for the different kinds of degree holders significantly
# different?
qplot(x = Degree, y = Income,
      geom = "boxplot", 
      data = loan.data,
      fill = I('green'))

# This data is normally distributed

ggplot(loan.data, aes(x = Income)) + 
  geom_histogram(col = "black", fill = "blue")

qqnorm(loan.data$Income, pch = 20, col = "darkgreen")
qqline(loan.data$Income, col = "red")

# p-value of the Shapiro-Wilk Test is greater than 0.05, the data is normal. 
# If it is below 0.05, the data significantly deviate from a normal distribution.
shapiro.test(loan.data$Income)

hs.incomes <- loan.data[loan.data$Degree == "HS      ", ]
head(hs.incomes)

college.incomes <- loan.data[loan.data$Degree == "College ", ]
head(college.incomes)

graduate.incomes <- loan.data[loan.data$Degree == "Graduate", ]
head(graduate.incomes)

# Null hypothesis: variances for the two groups are equal 
# Alternative hypothesis: variances for the two groups are NOT equal
# Since the p-value > 0.05 we can accept the null hypothesis and reject the
# alternative hypothesis, the variances are equal
leveneTest(Income ~ factor(Degree), data = loan.data)

# Null hypothesis: The mean incomes for the different groups are the same
# Alternative hypothesis: The mean incomes for the different groups are different
# Since p-value < 0.05 we can accept the alternative hypothesis, the mean incomes
# across groups are significantly different
aov.test <- aov(Income ~ factor(Degree), data = loan.data)
summary(aov.test)

# https://en.wikipedia.org/wiki/Tukey%27s_range_test
# In order to see which groups have means that are significantly different
# we need to use a different test, the Tukey Honest Significance Test
# Assumptions
# The observations being tested are independent within and among the groups.
# The groups associated with each mean in the test are normally distributed.
# There is equal within-group variance across the groups associated with each 
# mean in the test (homogeneity of variance).
TukeyHSD(aov.test)

###########################################################
# Two-way ANOVA with two independent variables
###########################################################

# Here we assume that the two factors do not interact with one another
# This is `additive model` i.e two factors are independent from each other. 
# https://roma.stat.wisc.edu/courses/st333-larget/review.pdf

aov.2way.test <- aov(Income ~ factor(Degree) + factor(Loan_type), data = loan.data)
summary(aov.2way.test)

# Here we assume that the two factors do  interact with one another
# This is `additive model` i.e two factors are dependent on one another. 
# https://roma.stat.wisc.edu/courses/st333-larget/review.pdf

# If you see the p-value for interaction you see that the independent variables
# do not really depend on one another
aov.2way.test <- aov(Income ~ factor(Degree) * factor(Loan_type), data = loan.data)
summary(aov.2way.test)











































