rm(list = ls())

life.exp.df <- read.csv("./datasets/life_exp.csv", header=TRUE)
head(life.exp.df)

gdp.pop.df <- read.csv("./datasets/gdp_pop.csv", header=TRUE)
head(gdp.pop.df)

# Joining dataframes using merge from base R

library(tidyverse)

# Very obvious that there is just one column on which join
merged.df <- merge(life.exp.df, gdp.pop.df)

# Things to note:
# The join automatically happens on the common column
# The join column should be an exact match
# Country and Year are not exact matches so columns from both tables in final result
slice_sample(merged.df, n=10)

# Note that this is an inner join
head(merged.df)

library(dplyr)
library(magrittr)

# What if the join columns do not have the same name?
gdp.pop.df <- rename(gdp.pop.df, "UniqueID" = "ID")
head(gdp.pop.df)

# Now we have to explicitly join by column

merged.df <- merge(life.exp.df, gdp.pop.df, by.x = "ID", by.y = "UniqueID")
head(merged.df)

# Other kinds of joins

# Full outer join
merged.df <- merge(life.exp.df, gdp.pop.df, 
                   by.x = "ID", by.y = "UniqueID",
                   all = TRUE)
head(merged.df %>% select(-c("COUNTRY", "YEAR", "Country", "Year")))

# Left outer join

merged.df <- merge(life.exp.df, gdp.pop.df, 
                   by.x = "ID", by.y = "UniqueID",
                   all.x =  TRUE)
head(merged.df %>% select(-c("COUNTRY", "YEAR", "Country", "Year")))

# Right outer join

merged.df <- merge(life.exp.df, gdp.pop.df, 
                   by.x = "ID", by.y = "UniqueID",
                   all.y =  TRUE)
head(merged.df %>% select(-c("COUNTRY", "YEAR", "Country", "Year")))


# Get rid of the ID column

life.exp.df <- life.exp.df[, -1]
head(life.exp.df)

gdp.pop.df <- gdp.pop.df[, -1]
head(gdp.pop.df)

# Can perform joins with multiple columns as join columns
merged.df <- merge(life.exp.df, gdp.pop.df, 
                   by.x = c("Country", "Year"), 
                   by.y = c("COUNTRY", "YEAR"))
head(merged.df)


# We now perform joins using dplyr
# Read in the original data frames

life.exp.tbl <- as_tibble(read.csv("./datasets/life_exp.csv", header=TRUE))
head(life.exp.tbl)

gdp.pop.tbl <- as_tibble(read.csv("./datasets/gdp_pop.csv", header=TRUE))
head(gdp.pop.tbl)

# The join will tell you what columns have been used for the join
merged.tbl <- inner_join(life.exp.tbl, gdp.pop.tbl)
head(merged.tbl)

# Get rid of the ID column

life.exp.tbl <- life.exp.tbl[, -1]
head(life.exp.tbl)

gdp.pop.tbl <- gdp.pop.tbl[, -1]
head(gdp.pop.tbl)

# This will be an error as the common columns don't have the same names
merged.tbl <- inner_join(life.exp.tbl, gdp.pop.tbl)

merged.tbl <- inner_join(life.exp.tbl, gdp.pop.tbl, 
                         by = c("Country" = "COUNTRY", "Year" = "YEAR"))
head(merged.tbl)



# What if the join columns have the same name?
gdp.pop.tbl <- rename(gdp.pop.tbl, "Country" = "COUNTRY", "Year" = "YEAR")
head(gdp.pop.tbl)

# Will now figure out what the join columns are
merged.tbl <- life.exp.tbl %>% inner_join(gdp.pop.tbl)

merged.tbl <- life.exp.tbl %>% inner_join(gdp.pop.tbl, by = c("Country", "Year"))
head(merged.tbl)

# dplyr also has left_join, right_join, full_join (not shown)

# Filter joins

# Filtering joins filter rows from x based on the presence or absence of 
# matches in y:
# semi_join() return all rows from x with a match in y.
# anti_join() return all rows from x without a match in y.

merged.tbl <- semi_join(life.exp.tbl, gdp.pop.tbl)
head(merged.tbl)

merged.tbl <- anti_join(life.exp.tbl, gdp.pop.tbl)
head(merged.tbl)
































