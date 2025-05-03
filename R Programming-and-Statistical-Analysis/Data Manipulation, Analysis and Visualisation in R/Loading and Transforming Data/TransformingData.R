rm(list = ls())

bank.customers.df <- read.csv("./datasets/BankCustomers.csv", header=TRUE)
head(bank.customers.df)

# Take a quick look at the column data types
str(bank.customers.df)

colnames(bank.customers.df)

# Drop the first two columns
bank.customers.df <- subset(bank.customers.df, select = -c(1, 2))
colnames(bank.customers.df)

head(bank.customers.df)

# Rename columns
colnames(bank.customers.df)[8]
colnames(bank.customers.df)[8] <- "NumProducts"
colnames(bank.customers.df)

# Rename columns (without knowing the position of the column)
colnames(bank.customers.df)[colnames(bank.customers.df) == 'Surname'] <- "Lastname"
colnames(bank.customers.df)


# Use the functionality in the dplyr package
# dplyr is a new package which provides a set of tools for efficiently 
# manipulating datasets in R. dplyr is the next iteration of plyr, focussing on 
# only data frames. dplyr is faster, has a more consistent API and should 
# be easier to use

# Dplyr is part of Tidyverse R packages for data science
# The tidyverse is an opinionated collection of R packages designed for data 
# science. All packages share an underlying design philosophy, grammar, and 
# data structures.

install.packages("dplyr")
library(dplyr)

# Note the new_col = old_col syntax

bank.customers.df <- rename(bank.customers.df, 
                            "Country" = "Geography", 
                            "IsActive" = "IsActiveMember")
colnames(bank.customers.df)

# Changing the data types of R columns

str(bank.customers.df)

bank.customers.df$Gender <- factor(bank.customers.df$Gender, 
                                   levels = c("Female", "Male"),
                                   ordered = FALSE)

str(bank.customers.df)


bank.customers.df$HasCrCard <- factor(bank.customers.df$HasCrCard, 
                                      levels = c(0, 1),
                                      ordered = FALSE)
bank.customers.df$IsActive <- factor(bank.customers.df$IsActive, 
                                      levels = c(0, 1),
                                      ordered = FALSE)
bank.customers.df$Exited <- factor(bank.customers.df$Exited, 
                                     levels = c(0, 1),
                                     ordered = FALSE)

str(bank.customers.df)

# Adding new columns

# We'll first add a new YearOfBirth column to our dataset using a formula

current.year <- as.numeric(format(Sys.Date(), "%Y"))
current.year

bank.customers.df$YearOfBirth <- current.year - bank.customers.df$Age
head(bank.customers.df)

# Use transform and a formula

bank.customers.df <- transform(bank.customers.df, Lastname = toupper(Lastname))
tail(bank.customers.df)

bank.customers.df <- transform(bank.customers.df,
                               EstimatedSalary = round(EstimatedSalary))
tail(bank.customers.df)

# Apply can apply functions in a row-wise or column-wise manner
# 1 - apply function by rwo
# 2 - apply function by column

apply(bank.customers.df, 2, function(column) {length(column)} )

# Note that the function has to work for every column of data that you have
# This code below will be an error
apply(bank.customers.df, 2, function(column) {mean(column)} )

# But this code will work since the columns are numeric
apply(bank.customers.df[c('Balance', 'EstimatedSalary')], 2, 
      function(column) {mean(column)} )


bank.customers.df$Points <- apply(bank.customers.df[, c('Balance', 'EstimatedSalary')], 1,
                                  function(row) {
                                    if (row[1] > 10000 && row[2] > 100000) {
                                      1000
                                    } else if  (row[1] > 10000) {
                                      600
                                    } else if (row[2] > 100000) {
                                      600
                                    } else {
                                      100
                                    }
                                  })

head(bank.customers.df[, c("Lastname", "Balance", "EstimatedSalary", "Points")])


bank.customers.df$Points <- apply(bank.customers.df[, c('CreditScore', 'Points')], 1,
                                  function(row) {
                                    if (row[1] > 600) {
                                      row[2] + 101
                                    } else {
                                      row[2]
                                    }
                                  })

head(bank.customers.df[, c("Lastname", "CreditScore", "Points")])

# Use the mapply function which is friendlier

increment_balance <- function(num.products, has.credit.card, balance) {
  
  if (num.products >=2 && has.credit.card == 1) {
    balance <- balance + 50
  } else if (has.credit.card == 1) {
    balance <- balance + 10
  } else {
    balance
  }
}


bank.customers.df$Balance <- mapply(increment_balance, 
                                    bank.customers.df$NumProducts,
                                    bank.customers.df$HasCrCard,
                                    bank.customers.df$Balance)

head(bank.customers.df[, c("Lastname", "NumProducts", "HasCrCard", "Balance")])


# Perform conditional evaluation using if-else

bank.customers.df$SeniorCitizensDepositRate <- ifelse(bank.customers.df$Age > 60, 1, 0)
head(bank.customers.df[bank.customers.df$Age > 60, ]
     [, c("Lastname", "Age", "SeniorCitizensDepositRate")])


# Using the mutate function from dplyr
# dplyr is part of the tidyverse universe of data science packages
# tidyverse involves working with data in the form of tibbles but the same
# functions can also work with data frames
# We will introduce tibbles in a future demo

bank.customers.df <- mutate(bank.customers.df, Points = Tenure * Points)
head(bank.customers.df)

# Can change multiple columns using mutate

bank.customers.df <- mutate(bank.customers.df, 
                            EligibleForOffer = if_else(Tenure > 2, TRUE, FALSE),
                            PlatinumCard = if_else(EstimatedSalary > 110000 && HasCrCard, 1, 0))
head(bank.customers.df)


# Can check for multiple conditions using case_when

bank.customers.df <- mutate(bank.customers.df, 
                            LoanRate = case_when(
                              CreditScore > 700 ~ 5,
                              CreditScore > 600 ~ 6,
                              CreditScore > 500 ~ 8,
                              CreditScore > 400 ~ 10,
                              TRUE ~ 13,
                            ))
head(bank.customers.df)

bank.customers.df <- mutate(bank.customers.df, 
                            LoanRate = case_when(
                              CreditScore > 700 || EstimatedSalary > 200000 ~ 5,
                              CreditScore > 600 || EstimatedSalary > 100000 ~ 6,
                              CreditScore > 500 ~ 8,
                              CreditScore > 400 ~ 10,
                              TRUE ~ 13,
                            ))
head(bank.customers.df)





























