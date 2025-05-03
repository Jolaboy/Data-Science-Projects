rm(list = ls())

# The z-test is exactly like the one-sample t-test:

# Assumptions
# Data is independent.
# Data is collected randomly.
# When your data is normally distributed  (for larger sample sizes this does 
# not matter)
# When your sample size > 30
# Population variance is known

install.packages("BSDA")
library(BSDA)
library(ggplot2)

insurance.data <- read.csv('./datasets/insurance.csv', stringsAsFactors = FALSE)
head(insurance.data)

table(insurance.data$sex)

ggplot(insurance.data, aes(x = charges)) + 
  geom_histogram(col = "black", fill = "red")

qqnorm(insurance.data$charges, col = "darkgreen")
qqline(insurance.data$charges, col = "darkgreen")

# For larger sample sizes data need not be normally distributed in order
# to use a z-test
dim(insurance.data)

# Let us get the standard deviation of charges and assume that this is the 
# standard deviation for the population
sd(insurance.data$charges)

mean(insurance.data$charges)

# Null hypothesis: Mean  == 13300
# Alternative hypothesis: Mean != 13300
# Here based on p-value > 0.05 alpha level we can accept the null hypothesis
# and reject the alternative hypothesis
z.test(insurance.data$charges, 
       sigma.x = sd(insurance.data$charges),
       mu = 13300)

# Null hypothesis: Mean  == 12000
# Alternative hypothesis: Mean != 12000
# Here based on p-value < 0.05 alpha level we can reject the null hypothesis
# and accept the alternative hypothesis
z.test(insurance.data$charges, 
       sigma.x = sd(insurance.data$charges),
       mu = 12000)
















































