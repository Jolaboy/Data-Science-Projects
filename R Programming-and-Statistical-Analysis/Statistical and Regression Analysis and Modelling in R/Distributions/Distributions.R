rm(list = ls())

install.packages("ggplot2")
library(ggplot2)

# Uniform distribution

# runif will not generate either of the extreme values unless 
# max = min or max-min is small compared to min, and in particular not for 
# the default arguments.
uniform.dist.data <- data.frame(val = runif(10, 1, 100))

hist(uniform.dist.data$val)
ggplot(uniform.dist.data, aes(x=val)) + geom_histogram()

uniform.dist.data <- data.frame(val = runif(100, 1, 100))
ggplot(uniform.dist.data, aes(x=val)) + geom_histogram()

uniform.dist.data <- data.frame(val = runif(100000, 1, 100))
ggplot(uniform.dist.data, aes(x=val)) + geom_histogram()

uniform.dist.data <- data.frame(val = runif(1000000, 1, 100))
ggplot(uniform.dist.data, aes(x=val)) + geom_histogram()

# The binomial distribution is a discrete probability distribution. 
# It describes the outcome of n independent trials in an experiment. Each 
# trial is assumed to have only two outcomes, either success or failure.

# Binomial distribution

# This article about R’s rbinom function is part of a series  about generating 
# random numbers using R. The rbinom function can be used to simulate the 
# outcome of Bernoulli trials. This is a fancy statistical word for flipping 
# coins. You can use it to calculate the number of successes in a set of 
# pass/fail trials with success estimated at probability p. 

# rbinom (# observations, # trails/observation, probability of success )

# Outcomes of 20 coin flips
rbinom(20, size = 1, prob = 0.5)

# 1000 widgets made per day, 3% chance the widgets are defective
# How many widgets will be rejected each day for the next 10 days
rbinom(10, size = 1000, prob = 0.03)

# Outcomes of 10 flips of a 100 coins (note roughly half of them heads)
rbinom(10, size = 200, prob = 0.5)

# If we flip a fair coin 10 times, what is the probability of 
# getting exactly 5 heads
dbinom(5, size = 10, prob = 0.5)

# If we flip a fair coin 10 times, what is the probability of 
# getting exactly 7 heads
dbinom(7, size = 10, prob = 0.5)

# If we flip a fair coin 10 times, what is the probability of 
# getting exactly 0 heads, 1 head, 2 heads...
dbinom(0:7, size = 10, prob = 0.5)

# If we flip a fair coin 10 times, what is the probability of getting 5 
# or fewer heads
pbinom(5, size = 10, prob = 0.5)

# If we flip a fair coin 10 times, what is the probability of getting 7 
# or fewer head
pbinom(7, size = 10, prob = 0.5)

# Visualizing binomial distributions
num.heads <- 0:20
binom.dis.data <- data.frame(val = dbinom(num.heads, size = 20, prob = 0.5))

ggplot(binom.dis.data, aes(x=num.heads, y=val)) + geom_line()

num.heads <- 300:700
binom.dis.data <- data.frame(x = dbinom(num.heads, size = 1000, prob = 0.5))

ggplot(binom.dis.data, aes(num.heads, y=x)) + geom_point()

# What if the coin is not fair?
num.heads <- 0:20
binom.dis.data <- data.frame(x = dbinom(num.heads, size = 20, prob = 0.8))

ggplot(binom.dis.data, aes(num.heads, y=x)) + geom_line()

num.heads <- 0:20
binom.dis.data <- data.frame(x = dbinom(num.heads, size = 20, prob = 0.3))

ggplot(binom.dis.data, aes(num.heads, y=x)) + geom_line()

# Poisson distribution

# The Poisson distribution is commonly used to model the number of expected 
# events for a process given we know the average rate at which events occur
# during a given unit of time. 

# For example, let us assume that 10 customers visit a website per minute.

# Can we generate a simulation of the number of customers per minute for 
# the next 20 minutes?

# We describe the process as:
# lambda = A rate of occurrence – how often is an event expected to occur 
# in that window
# n = The number of times an event occurs (the observation)

rpois(n = 20, lambda = 10)

# Number of customer complaints per day for an e-commerce site is 50
# How many complaints can you expect to receive over the next 7 days

rpois(n = 7, lambda = 50)

# Customers complaints come in at 10 per hour. What is the 
# probability of having exactly 7 customers call us within the span of 
# an hour?

dpois(7, lambda=10)

# Customers complaints come in at 10 per hour. What is the 
# probability of having exactly 10 customers call us within the span of 
# an hour?
dpois(10, lambda=10)

# Customers complaints come in at 10 per hour. What is the 
# probability of having exactly 10 customers call us within the span of 
# an hour?
dpois(2, lambda=10)

# Customer complaints come in at 20 an hour. What is the probability of getting
# 7 or fewer complaints in an hour?
ppois(7, lambda = 20)

# Customer complaints come in at 20 an hour. What is the probability of getting
# 25 or more complaints in an hour?
1 - ppois(25, lambda = 25)

# Visualizing Poisson distributions (rate is 10 complaints an hour)

num.complaints <- 0:40
poisson.dis.data <- data.frame(val = dpois(num.complaints, lambda = 10))

ggplot(poisson.dis.data, aes(x=num.complaints, y=val)) + geom_line()

num.complaints <- 0:40
poisson.dis.data <- data.frame(val1 = dpois(num.complaints, lambda = 5),
                               val2 = dpois(num.complaints, lambda = 8),
                               val3 = dpois(num.complaints, lambda = 12),
                               val4 = dpois(num.complaints, lambda = 15),
                               val5 = dpois(num.complaints, lambda = 10))

ggplot(poisson.dis.data, aes(x=num.complaints)) + 
  geom_line(aes(y = val1, color="red")) +
  geom_line(aes(y = val2, color="blue")) +
  geom_line(aes(y = val3, color="green")) +
  geom_line(aes(y = val4, color="yellow")) +
  geom_line(aes(y = val5, color="orange"))

# Normal distribution

# Standard normal distribution mean=0, sd=1
rnorm(10, mean = 0, sd = 1)

ggplot(data = data.frame(x = c(-5, 5)), aes(x)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1)) +
  scale_y_continuous(breaks = NULL)

ggplot(data = data.frame(x = c(-10, 34)), aes(x)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 12, sd = 5)) +
  scale_y_continuous(breaks = NULL)

ggplot(data = data.frame(x = c(-5, 5)), aes(x)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 2)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 3)) +
  scale_y_continuous(breaks = NULL)

# Exponential distribution

x <- seq(0, 20, length.out = 1000)
exp.dis.data <- data.frame(x = x, px = dexp(x, rate=0.65))

ggplot(exp.dis.data, aes(x=x, y=px)) + geom_line()

x <- seq(0, 20, length.out = 1000)
exp.dis.data <- data.frame(x = x, px = dexp(x, rate=0.35))

ggplot(exp.dis.data, aes(x=x, y=px)) + geom_line()


# Q-Q plots can be used to compare distribution to normal or to compare the
# distribution of two datasets
# https://data.library.virginia.edu/understanding-q-q-plots/
# https://www.itl.nist.gov/div898/handbook/eda/section3/qqplot.htm

# qqnorm is a generic function the default method of which produces a normal 
# QQ plot of the values
qqnorm(rnorm(1000, mean = 0, sd = 1))
dev.off()

qqnorm(rnorm(1000, mean = 10, sd = 1.8))
dev.off()

# qqline adds a line to a “theoretical”, by default normal, quantile-quantile 
# plot which passes through the probs quantiles, by default the first and third quartiles
qqnorm(rnorm(1000, mean = 0, sd = 1))
qqline(rnorm(1000, mean = 0, sd = 1))
dev.off()

# For example, if the two data sets come from populations whose distributions 
# differ only by a shift in location, the points should lie along a straight 
# line that is displaced either up or down from the 45-degree reference line.
qqnorm(rnorm(1000, mean = 1, sd = 1))
qqline(rnorm(1000, mean = 0, sd = 1))
dev.off()

qqnorm(rnorm(1000, mean = 0, sd = 2))
qqline(rnorm(1000, mean = 0, sd = 1))
dev.off()

qqnorm(rexp(1000, rate = 0.35))
dev.off()

qqnorm(rchisq(1000, df = 7))
dev.off()

# The qqplot function allows you to create a Q-Q plot for any distribution. 
# Unlike the qqnorm function, you have to provide two arguments: the first set 
# of data and the second set of data.
# # https://data.library.virginia.edu/understanding-q-q-plots/
qqplot(rnorm(1000, mean = 0, sd = 1), rnorm(1000, mean = 0, sd = 1))
dev.off()

qqplot(rchisq(500, df = 7), rnorm(1000, mean = 0, sd = 1))
dev.off()

qqplot(rcauchy(500), rnorm(1000, mean = 0, sd = 1))




