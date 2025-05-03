rm(list = ls())

# Read in and set up the dataset

bank.churners.df <- read.csv("./datasets/BankChurners.csv", header=TRUE)
head(bank.churners.df)

str(bank.churners.df)

bank.churners.df$Attrition_Flag <- 
  factor(bank.churners.df$Attrition_Flag, 
         levels=unique(bank.churners.df$Attrition_Flag))

bank.churners.df$Gender <- 
  factor(bank.churners.df$Gender, 
         levels=unique(bank.churners.df$Gender))

bank.churners.df$Education_Level <- 
  factor(bank.churners.df$Education_Level, 
         levels=unique(bank.churners.df$Education_Level))

bank.churners.df$Marital_Status <- 
  factor(bank.churners.df$Marital_Status, 
         levels=unique(bank.churners.df$Marital_Status))

unique(bank.churners.df$Income_Category)

bank.churners.df$Income_Category <- 
  ordered(bank.churners.df$Income_Category, 
         levels=c("Unknown",
                  "Less than $40K", 
                  "$40K - $60K",
                  "$60K - $80K",
                  "$80K - $120K",
                  "$120K +"))

unique(bank.churners.df$Card_Category)

bank.churners.df$Card_Category <- 
  ordered(bank.churners.df$Card_Category, 
         levels=c("Blue", "Gold", "Silver", "Platinum"))

# See the final data types of this data.frame
str(bank.churners.df)

# Filtering operations on columns

colnames(bank.churners.df)

bank.churners.personal <- bank.churners.df[, 3:8]
head(bank.churners.personal)

bank.churners.professional <- bank.churners.df[, c(1, 2, 9, 10, 11, 12, 13)]
head(bank.churners.professional)

bank.churners.family <- bank.churners.df[, c("Dependent_count", "Marital_Status")]
head(bank.churners.family)

bank.churners.underscore <- bank.churners.df[, grep("_", colnames(bank.churners.df))]
head(bank.churners.underscore)


# Filtering operations on rows using direct manipulation of data frames

bank.churners.filtered <- bank.churners.df[1:8,]
head(bank.churners.filtered)

bank.churners.filtered <- bank.churners.df[c(2, 4, 6, 8),]
head(bank.churners.filtered)

# Comparison operations

bank.churners.filtered <- bank.churners.df[bank.churners.df$Gender == "F",]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[bank.churners.df$Education_Level == "High School",]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[bank.churners.df$Customer_Age > 60,]
head(bank.churners.filtered)

# Note that we compare ordered factors
bank.churners.filtered <- 
  bank.churners.df[bank.churners.df$Card_Category > "Gold",]
head(bank.churners.filtered)

# Logical operations

bank.churners.filtered <- 
  bank.churners.df[(bank.churners.df$Dependent_count > 0 & 
                     bank.churners.df$Marital_Status == "Married"),]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[(bank.churners.df$Months_on_book > 40 & 
                      bank.churners.df$Card_Category == "Gold"),]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[(bank.churners.df$Total_Revolving_Bal > 5000 | 
                      bank.churners.df$Credit_Limit > 20000),]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[!(bank.churners.df$Education_Level == "Unknown"),]
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[(bank.churners.df$Education_Level %in% 
                      c("Graduate", "Post-Graduate", "Doctorate")),]
tail(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.df[(grep("Doctorate", bank.churners.df$Education_Level)),]
tail(bank.churners.filtered)


# A tibble, or tbl_df, is a modern reimagining of the data.frame, keeping what 
# time has proven to be effective, and throwing out what is not. Tibbles are 
# data.frames that are lazy and surly: they do less (i.e. they don’t change 
# variable names or types, and don’t do partial matching) and complain more 
# (e.g. when a variable does not exist). This forces you to confront problems 
# earlier, typically leading to cleaner, more expressive code. Tibbles also 
# have an enhanced print() method which makes them easier to use with large 
# datasets containing complex objects.

# Tibbles are part of the tidyverse and when we work with the deplyr package
# for filtering we will be using tibbles

# This includes dplyr which is what we will use

install.packages("tidyverse")
library(tidyverse)

bank.churners.tbl <- as_tibble(bank.churners.df)
head(bank.churners.tbl)

# Here on in this demo we will perform our operations on the tibble

# select() allows us to select columns in our tibble (or data frame)

bank.churners.filtered <- select(bank.churners.tbl, 
                                 Gender, Income_Category, 
                                 Credit_Limit, Total_Revolving_Bal)
head(bank.churners.filtered)


# Provides a mechanism for chaining commands with a new forward-pipe operator, 
# %>%. This operator will forward a value, or the result of an expression,
# into the next function call/expression. There is flexible support for the 
# type of right-hand side expressions.
# Installed along with tidyverse

library("magrittr")

# Select all columns EXCEPT

bank.churners.filtered <- bank.churners.tbl %>% select(-c(Gender, 
                                                          Income_Category, 
                                                          Credit_Limit, 
                                                          Total_Revolving_Bal))
head(bank.churners.filtered)

# Select a range of columns

bank.churners.filtered <- bank.churners.tbl %>% select(Customer_Age:Education_Level)
head(bank.churners.filtered)

# starts_with and ends_with

bank.churners.filtered <- bank.churners.tbl %>% select(starts_with("To"))
head(bank.churners.filtered)


bank.churners.filtered <- bank.churners.tbl %>% select(ends_with("Count"))
head(bank.churners.filtered)

# Match a regular expression

bank.churners.filtered <- bank.churners.tbl %>% select(matches("*ion*"))
head(bank.churners.filtered)


# Selecting rows

bank.churners.tbl %>% slice(4:9)

bank.churners.filtered <- bank.churners.tbl %>% slice(4:9)
bank.churners.filtered

# The filter() operation in dplyr has much friendlier syntax for filtering 
# operations

bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Education_Level == "Unknown")
head(bank.churners.filtered)

# This will perform an && logical operation

bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Education_Level == "Unknown", Gender == "F")
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Marital_Status == "Married", Dependent_count == 0)
head(bank.churners.filtered)

bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Marital_Status %in% c("Single", "Divorced"), 
                               Dependent_count > 0 )
head(bank.churners.filtered)

# Note that we compare ordered factors
bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Marital_Status %in% c("Single", "Divorced"), 
                               Income_Category > "$80K - $120K" )
head(bank.churners.filtered[c("Marital_Status", "Income_Category")])

# Using the logical OR

bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Marital_Status == "Married" | Gender == "F")
head(bank.churners.filtered)


bank.churners.filtered <- 
  bank.churners.tbl %>% filter(Marital_Status == "Single" | Gender == "F", 
                               Dependent_count == 0)
head(bank.churners.filtered)


# Select random records from the data frame

bank.churners.sampled <- 
  bank.churners.tbl %>% sample_n(10, replace = FALSE)
bank.churners.sampled

# Sample number of records

bank.churners.sampled <- 
  bank.churners.tbl %>% 
      filter(Marital_Status %in% c("Single", "Divorced"), 
             Income_Category > "$80K - $120K" ) %>%
      sample_n(10, replace = FALSE)
bank.churners.sampled

# Sample percentage

bank.churners.sampled <- 
  bank.churners.tbl %>% 
      filter(Income_Category > "Unknown") %>%
      sample_n(5, replace = FALSE) %>%
      select(Gender, Income_Category, Marital_Status, Total_Revolving_Bal)
bank.churners.sampled


# Select top-n based on a certain column

bank.churners.topn <- bank.churners.tbl %>% 
  top_n(5, Credit_Limit) %>% 
  select(Gender, Income_Category, Credit_Limit)
head(bank.churners.topn)

bank.churners.topn <- bank.churners.tbl %>% 
  top_n(5, Total_Revolving_Bal) %>% 
  select(Gender, Income_Category, Total_Revolving_Bal)
head(bank.churners.topn)















































