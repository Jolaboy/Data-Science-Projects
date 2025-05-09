install.packages("languageserver")
rm(list = ls())

car.prices.df <- read.csv("./datasets/CarPrice_Assignment.csv", header=TRUE)
head(car.prices.df)

car.prices.df <- car.prices.df[, c("CarName", "fueltype", "doornumber",
                                   "carbody", "drivewheel", "curbweight",
                                   "horsepower", "citympg", "highwaympg",
                                   "price")]
head(car.prices.df)

str(car.prices.df)

car.prices.df$fueltype <- 
  factor(car.prices.df$fueltype, levels=unique(car.prices.df$fueltype))

car.prices.df$doornumber <- 
  factor(car.prices.df$doornumber, levels=unique(car.prices.df$doornumber))

car.prices.df$carbody <- 
  factor(car.prices.df$carbody, levels=unique(car.prices.df$carbody))

# Order in terms of traction in the snow
car.prices.df$drivewheel <- 
  ordered(car.prices.df$drivewheel, levels=c("rwd", "fwd", "4wd"))

str(car.prices.df)

# Use the order() function from the base package for sorting data frames

order(car.prices.df$horsepower)

# Default is ascending order
car.prices.ordered <- car.prices.df[order(car.prices.df$horsepower), ]
head(car.prices.ordered)

car.prices.ordered <- car.prices.df[order(car.prices.df$price), ]
head(car.prices.ordered)

# Descending order
car.prices.ordered <- car.prices.df[order(desc(car.prices.df$horsepower)), ]
head(car.prices.ordered)

car.prices.ordered <- car.prices.df[order(-car.prices.df$price), ]
head(car.prices.ordered)

car.prices.ordered <- car.prices.df[order(car.prices.df$drivewheel), ]
head(car.prices.ordered)

# Multiple columns

car.prices.ordered <- car.prices.df[order(car.prices.df$drivewheel, 
                                          -car.prices.df$horsepower), ]
head(car.prices.ordered)

# Use tibbles and the dplyr library for sorting data

library(tidyverse)
library(magrittr)

car.prices.tbl <- as_tibble(car.prices.df)
head(car.prices.tbl)

car.prices.ordered <- car.prices.tbl %>% arrange(price)
head(car.prices.ordered)

car.prices.ordered <- car.prices.tbl %>% arrange(desc(price))
head(car.prices.ordered)

car.prices.ordered <- car.prices.tbl %>% arrange(-price)
head(car.prices.ordered)

car.prices.ordered <- car.prices.tbl %>% arrange(-price, -horsepower)
head(car.prices.ordered)


# Grouping operations without using tidyverse basically involves creating
# tables to see how many records are in each group

# These operations are performed on data frames

car.prices.table <- table(car.prices.df$fueltype)
car.prices.table

car.prices.table <- table(car.prices.df$drivewheel)
car.prices.table

car.prices.table <- table(car.prices.df$carbody)
car.prices.table

# Get information in the form of proportions
car.prices.table <- prop.table(table(car.prices.df$carbody))
car.prices.table

car.prices.table <- table(car.prices.df$carbody, car.prices.df$drivewheel)
car.prices.table

car.prices.table <- prop.table(table(car.prices.df$carbody, 
                                     car.prices.df$drivewheel))
car.prices.table

car.prices.table <- table(car.prices.df$fueltype, car.prices.df$drivewheel)
car.prices.table

# table is great for counts, but what if you want to do something else? 
# aggregate is a neat way of extending this functionality, allowing you apply 
# a variety of different statistics by groups.

str(car.prices.df)

aggregate(car.prices.df$horsepower ~ car.prices.df$drivewheel,
          FUN = max)

aggregate(car.prices.df$horsepower ~ car.prices.df$drivewheel,
          FUN = mean)

aggregate(price ~ carbody,
          data = car.prices.df, FUN = mean)

aggregate(price ~ carbody,
          data = car.prices.df, FUN = median)

aggregate(citympg ~ carbody,
          data = car.prices.df, FUN = mean)

aggregate(citympg ~ carbody + fueltype,
          data = car.prices.df, FUN = mean)

aggregate(citympg ~ carbody,
          data = car.prices.df, FUN = c(mean, median))

aggregate(citympg ~ carbody,
          data = car.prices.df, FUN = function(x) {

            result <- c(mean(x), median(x))
            names(result) <- c("mean", "median")
            
            result
          })

aggregate(citympg ~ carbody,
          data = car.prices.df, FUN = function(x) {
            quantile(x, c(.25, .5, .75))
          })

# Using the dplyr package to create summaries, perform grouping and aggregation
# This will work on data frames as well as tibbles

summarise(car.prices.tbl, count=n())

# summarise() and summarize() are synonyms 
summarize(car.prices.tbl, count=n_distinct(CarName))

car.prices.tbl %>% summarize(count=n_distinct(carbody))

car.prices.tbl %>% summarize(count=n(), mean=mean(price))

car.prices.tbl %>% summarize(count=n(), 
                             mean.price=mean(price), 
                             mean.citympg=mean(citympg))

car.prices.tbl %>% summarize(count=n(), 
                             min.price=min(price), 
                             max.price=max(price))


# Grouping operations using group by

# grouping doesn't change how the data looks (apart from listing
# how it's grouped):
car.prices.tbl %>% group_by(drivewheel)

car.prices.grouped.doornumber <- car.prices.tbl %>% group_by(doornumber)
car.prices.grouped.doornumber

# It changes how it acts with the other dplyr verbs:
summarize(car.prices.grouped.doornumber, count=n())

car.prices.grouped.doornumber %>% summarize(count=n())

car.prices.grouped.doornumber %>% summarize(count=n(), 
                                            mean.price=mean(price), 
                                            mean.highwaympg=mean(highwaympg))

car.prices.grouped.doornumber %>% filter(price == max(price))

car.prices.grouped.doornumber %>% 
  filter(price == max(price)) %>%
  select(CarName, fueltype, doornumber, price)

# Group by carbody

car.prices.grouped.carbody <- car.prices.tbl %>% group_by(carbody)
car.prices.grouped.carbody

car.prices.grouped.carbody %>% summarize(count=n(), 
                                         mean.price=mean(price), 
                                         median.price=median(price), 
                                         mean.highwaympg=mean(highwaympg),
                                         median.highwaympg=median(highwaympg))

car.prices.grouped.carbody %>% 
  summarize(count=n(), mean.price=mean(price), median.price=median(price))  %>% 
  filter(count > 20)

car.prices.grouped.carbody %>% 
  summarize(count=n(), mean.price=mean(price), median.price=median(price))  %>% 
  filter(count > 20, median.price > 10000)

# Can group by multiple columns

car.prices.grouped.carbody.fueltype <- car.prices.tbl %>% 
  group_by(carbody, fueltype)
car.prices.grouped.carbody.fueltype

car.prices.grouped.carbody.fueltype %>% 
  summarize(count=n(), mean.price=mean(price), median.price=median(price))

# To remove grouping use the ungroup operation

car.prices.grouped.carbody
car.prices.grouped.carbody %>% ungroup()

# Can remove multiple levels of groups

car.prices.grouped.carbody.fueltype
car.prices.grouped.carbody.fueltype %>% ungroup()

# Another grouping removes previous groups
car.prices.grouped.drivewheel <- 
  car.prices.grouped.carbody.fueltype %>% group_by(drivewheel)


# Grouping on continuous values
cut(car.prices.tbl$price, c(0, 6000, 12000, 18000, 24000, 30000, 36000))

car.prices.tbl <- car.prices.tbl %>%  mutate(price.categories = 
                                            cut(car.prices.tbl$price, 
                                            c(0, 6000, 
                                              12000, 18000, 
                                              24000, 30000, 36000)))

car.prices.tbl %>% select(CarName, price, price.categories) %>% sample_n(10)










