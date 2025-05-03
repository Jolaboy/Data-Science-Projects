rm(list = ls())

# https://en.wikipedia.org/wiki/Paired_difference_test
# The differences in the pairs should be normally distributed for T-test

happiness.2015 <- read.csv("./datasets/2015.csv")
happiness.2016 <- read.csv("./datasets/2016.csv")

head(happiness.2015)
head(happiness.2016)

happiness.2015 <- happiness.2015[, c("Country", "Happiness.Score")]
head(happiness.2015)

happiness.2016 <- happiness.2016[, c("Country", "Happiness.Score")]
head(happiness.2016)

install.packages("tidyverse")
install.packages("magrittr")
library(tidyverse)
library(magrittr)

happiness.2015 <- happiness.2015 %>% arrange(Country)
head(happiness.2015)

happiness.2016 <- happiness.2016 %>% arrange(Country)
head(happiness.2016)

dim(happiness.2015)
dim(happiness.2016)

# The data is NOT normally distributed
qqnorm(happiness.2015$Happiness.Score, pch = 20, col = "darkgreen")
qqline(happiness.2015$Happiness.Score, col = 'red', lwd = 2.5)

qqnorm(happiness.2016$Happiness.Score, pch = 20, col = "darkgreen")
qqline(happiness.2016$Happiness.Score, col = 'red', lwd = 2.5)

shapiro.test(happiness.2015$Happiness.Score)

shapiro.test(happiness.2016$Happiness.Score)

# The differences between pairs of data are NOT normally distributed
happiness.score.diff <- 
  happiness.2016$Happiness.Score - happiness.2015$Happiness.Score

qqnorm(happiness.score.diff, pch = 20, col = "darkgreen")
qqline(happiness.score.diff, col = 'red', lwd = 2.5)

shapiro.test(happiness.score.diff)

# The t-test is not valid since its assumptions do not hold true
t.test(happiness.2015$Happiness.Score, 
       happiness.2016$Happiness.Score, paired = TRUE)

# https://en.wikipedia.org/wiki/Wilcoxon_signed-rank_test
# https://www.statisticshowto.com/wilcoxon-signed-rank-test/
# This non-parametric test is the right one to use here
# Accept the null hypothesis - no significant difference in happiness scores
# The Wilcoxon test compares medians and not means
wilcox.test(happiness.2015$Happiness.Score, 
       happiness.2016$Happiness.Score, paired = TRUE)



















