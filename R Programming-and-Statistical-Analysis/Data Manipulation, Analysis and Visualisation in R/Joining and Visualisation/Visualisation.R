rm(list = ls())

bank.loan.df <- read.csv("./datasets/data_loan.csv")

dim(bank.loan.df)

head(bank.loan.df)

colSums(is.na(bank.loan.df))

str(bank.loan.df)

# Perform R expressions using the items (variables) contained in a list or 
# data frame. The within function will even keep track of changes made, 
# including adding or deleting elements, and return a new object with these 
# revised contents.

bank.loan.df <- within(bank.loan.df, {
  Default <- as.factor(Default) 
  Loan_type <- as.factor(Loan_type) 
  Gender <- as.factor(Gender) 
  Degree <- as.factor(Degree) 
  Citizenship <- as.factor(Citizenship)
})

str(bank.loan.df)

# Over its lifetime, R has accumulated three different plotting systems.

# base graphics are the oldest system, having been around as long as R 
# itself. base graphs are easy to get started with, but they require a lot 
# of fiddling and magic incantations to polish, and are very hard to extend 
# to new graph types. grid allows for more flexible plotting but is very low
# level

# The second plotting system, lattice, is built on top of the grid system, 
# providing highlevel functions for all the common plot types. I

# The ggplot2 system, also built on top of grid, is the most modern of the three 
# plotting systems. The “gg” stands for “grammar of graphics,''2 which aims to 
# break down graphs into component chunks. The result is that code for a ggplot 
# looks a bit like the English way of articulating what you want in the graph.
# The good news is that you can do almost everything you want in ggplot2, so 
# learning all three systems is mostly overkill.      

# First we will use the base graphics package hist(), plot() are from this package

hist(bank.loan.df$Age)

hist(bank.loan.df$Age, xlab="Customer Age", ylab = "Count of records", 
     main = "Customer Age Histogram")

hist(bank.loan.df$Age, xlab="Customer Age", ylab = "Count of records", 
     main = "Customer Age Histogram", breaks=10, col="red")

# Density curve

density(bank.loan.df$Income)

plot(density(bank.loan.df$Income))

polygon(density(bank.loan.df$Income), col="green", border="blue")

install.packages(ggplot2)
library(ggplot2)

# Aesthetic mappings describe how variables in the data are mapped to visual 
# properties (aesthetics) of geoms. Aesthetic mappings can be set in ggplot() 
# and in individual layers

# This should display nothing
ggplot(bank.loan.df, aes(x=Income)) 

# Visualise the distribution of a single continuous variable by dividing the 
# x axis into bins and counting the number of observations in each bin. 
# Histograms (geom_histogram()) display the counts with bars; frequency 
# polygons (geom_freqpoly()) display the counts with lines. Frequency polygons 
# are more suitable when you want to compare the distribution across the levels 
# of a categorical variable.

# Now we can see the histogram
ggplot(bank.loan.df, aes(x=Income)) + geom_histogram()

ggplot(bank.loan.df, aes(x=Income)) + geom_freqpoly()

ggplot(bank.loan.df, aes(x=Income)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") 


# Scatter plot

attach(bank.loan.df)
plot(Credit_score, Income, main="Credit Score vs. Income")

# Using ggplot2

ggplot(bank.loan.df, aes(x=Credit_score, y=Income)) + geom_point()

ggplot(bank.loan.df, aes(x=Credit_score, y=Income)) + 
  geom_point(size=3, shape=15)

ggplot(bank.loan.df, aes(x=Credit_score, y=Income)) + 
  geom_point(size=Loan_length)

ggplot(bank.loan.df, aes(x=Credit_score, y=Income)) + 
  geom_point(size=Loan_length, alpha=0.3)

ggplot(bank.loan.df, aes(x=Credit_score, y=Income)) + 
  geom_point(size=Loan_length, alpha=0.3, colour = "blue")

ggplot(bank.loan.df, aes(x=Credit_score, y=Income, colour=Gender)) + 
  geom_point(size=Loan_length, alpha=0.3)

# Box plots

boxplot(bank.loan.df$Income, main="Summary statistics for Income")

boxplot(bank.loan.df$Income ~ bank.loan.df$Degree, 
        main="Summary statistics for Income by Degree")


# Using ggplot

ggplot(bank.loan.df, aes(x=Degree, y=Income)) + geom_boxplot()

ggplot(bank.loan.df, aes(x=Degree, y=Income)) + geom_boxplot(notch=TRUE)

ggplot(bank.loan.df, aes(x=Gender, y=Income)) + 
  geom_boxplot(outlier.colour="blue", outlier.shape=8,
               outlier.size=4)

ggplot(bank.loan.df, aes(x=Gender, y=Income, color=Gender)) + 
  geom_boxplot(outlier.colour="blue", outlier.shape=8,
               outlier.size=4)

# Line chart

tsla.weekly.df <- read.csv("./datasets/TSLA_weekly.csv")
head(tsla.weekly.df)

str(tsla.weekly.df)

tsla.weekly.df$Date = as.Date(tsla.weekly.df$Date, format="%Y-%m-%d")

tr(tsla.weekly.df)

plot(Close ~ Date, tsla.weekly.df, type = "l")

# Using ggplot

ggplot(data=tsla.weekly.df, aes(x=Date, y=Close)) +
  geom_line() +  geom_point()

ggplot(data=tsla.weekly.df, aes(x=Date, y=Open)) +
  geom_line(color="red", arrow = arrow()) +  geom_point()









