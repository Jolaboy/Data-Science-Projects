rm(list = ls())

PlantGrowth

unstacked_PG <- unstack(PlantGrowth)
unstacked_PG

stacked_PG <- stack(unstacked_PG)
stacked_PG

# Wide form data

# NA values can waste a lot of space in this representation

child.weights <- data.frame(name = c("Allison", 
                                     "Bethany", 
                                     "Charlize", 
                                     "Dominic",
                                     "Esther",
                                     "Fred",
                                     "Gerald",
                                     "Harry"),
                            gender = factor(c("F", "F", "F", "M", "F", "M", "M", "M"), 
                                            levels = c("F", "M")),
                            year.1 = c(22, NA, 23, 24, 19, 20, 24, 26),
                            year.2 = c(28, NA, 27, 24, 24, 29, 32, 34),
                            year.3 = c(31, 35, 33, 36, NA, NA, NA, 39),
                            year.4 = c(35, 40, 39, 42, 47, 36, NA, 44),
                            year.5 = c(37, 44, 47, 47, 49, 40, NA, 49),
                            stringsAsFactors = FALSE)

child.weights

# Many different functions to convert this data to long form

# This does not work, as we don't want the entire data to be stacked
stack(child.weights)

# This will work, we only stack the year information but not the name 
# and gender columns
stacked.child.weights <- data.frame(child.weights[c("name", "gender")], 
                                    stack(child.weights[c("year.1", 
                                                          "year.2", 
                                                          "year.3", 
                                                          "year.4", 
                                                          "year.5")]))
stacked.child.weights

# This will not work
unstack(stacked.child.weights)

# This will work
unstacked.child.weights <- data.frame(child.weights[c("name", "gender")], 
                                      unstack(stacked.child.weights[c("values", "ind")]))
unstacked.child.weights

identical(child.weights, unstacked.child.weights)

# The stack() and unstack() methods are not that easy to use
# The reshape() function, which is confusingly not part of the reshape2 package; 
# it is part of the base install of R. This was very hard to use which is why
# the reshape2 package introduced melt and dcast

install.packages("reshape2")
library(reshape2)

# Use melt to go from wide to long data

child.weights.long <- melt(child.weights, id.vars = c("name", "gender"))
child.weights.long

child.weights.long <- melt(child.weights, 
                           id.vars = c("name", "gender"),
                           # Source columns
                           measure.vars = c("year.1", 
                                            "year.2", 
                                            "year.3", 
                                            "year.4", 
                                            "year.5"),
                           # Destination columns
                           variable.name = "year",
                           value.name = "lbs")
child.weights.long

# Melt is also able to infer the id variables in certain cases

child.weights.long <- melt(child.weights, 
                           # Destination columns
                           variable.name = "year",
                           value.name = "lbs")
child.weights.long

# Use dcast to go from long to wide data

child.weights.wide <- dcast(child.weights.long, 
                            formula = name + gender ~ year, value.var = "lbs")
child.weights.wide

# Let's now use melt() and dcast() on a real dataset

# TODO Recording: Please show the dataset in sublimetext before we work with it

oil.df <- read.csv("./datasets/U.S._crude_oil_production.csv", header=TRUE)

colnames(oil.df)
head(oil.df)

oil.df.long <- melt(oil.df, 
                    id.vars = c("Date"), 
                    variable.name = "Region",
                    value.name = "Quantity")
head(oil.df.long)
tail(oil.df.long)

us.crude.oil <- oil.df.long[oil.df.long$Region == "US_Crude_Oil", ]
us.crude.oil

# TODO Recording: Hide the graph after it has been displayed so the console
# takes up the entire RHS
plot(us.crude.oil$Quantity ~ as.Date(us.crude.oil$Date, "%d/%m/%y"), type = 'o')

# Convert back to wide form

oil.df.wide <- dcast(oil.df.long, formula = Date ~ Region, value.var = "Quantity")
head(oil.df.wide)

# The tidyr package is a part of the tidyverse universe. tidyr is used to clean 
# your data i.e. tidy your data

install.packages("tidyr")
library(tidyr)

child.weights

# Use bare, unquoted column names when using the gather() function

child.weights.long <- gather(child.weights, year, lbs, 
                             # Gather specific source columns from year.1:year.5
                             year.1:year.5, factor_key = TRUE)
child.weights.long

# In order to specify the column names as strings use the gather_() function

child.weights.long <- gather_(child.weights, "year", "lbs", 
                             # Gather specific source columns from year.1:year.5
                             c("year.1", 
                               "year.2", 
                               "year.3", 
                               "year.4", 
                               "year.5"), factor_key = TRUE)
child.weights.long

# Use spread() to go from long to wide

child.weights.wide <- spread(child.weights.long, year, lbs)
child.weights.wide

child.weights.wide <- spread_(child.weights.long, "year", "lbs")
child.weights.wide

# Let's now use gather() and spread() on a real dataset

# TODO Recording: Please show the dataset in sublimetext before we work with it

life.df <- read.csv("./datasets/life_expectancy.csv", header=TRUE)
head(life.df)

# Convert to wide form using spread

life.df.wide <- spread(life.df, Year, Life.expectancy)
head(life.df.wide)

life.df.long <- gather(life.df.wide, Year, Life.expectancy, "2000":"2015")
tail(life.df.long)











