# TODO Recording
# - Please make sure that you start with a clean script file and console
# - Clear the console by hitting ctrl + L on the console window
# - As you record please keep cleaning the console periodically

rm(list=ls())

View(installed.packages())

# One of the packages in the base R distribution is called  datasets, and it is 
# entirely filled with example datasets.

data()

data(package=.packages(TRUE))

data(package = "MASS")

install.packages("sandwich")
data(package = "sandwich")

# Per capita expenditure on public schools and per capita income by state in 1979

data("PublicSchools", package = "sandwich")
head(PublicSchools, 10)

str(PublicSchools)

nrow(PublicSchools)
ncol(PublicSchools)

summary(PublicSchools)

# TODO Recording: 
# Please hide the plots after they are displayed so the console
# once again spans the whole of the right side

hist(PublicSchools$Expenditure, col = "green")
hist(PublicSchools$Income, col = "red")

plot(PublicSchools)

# TODO Recording: 
# The line below will open up a browser window
# - Click on the PDF link next to "The survival package"
# - Show that the vignette for this package is available

browseVignettes(package = "survival")

# Partial results from a trial of laser coagulation for the treatment of
# diabetic retinopathy.

data("diabetic", package = "survival")
head(diabetic, 10)

str(diabetic)

contingency.table <- table(diabetic$laser, diabetic$eye)
contingency.table

addmargins(contingency.table)

# Read files which are stored in an RDataset format
# This storage method is efficient and the only drawback is that, because it is 
# stored in an R binary format, you can only open it in R [there are some 
# exceptions that will not be discussed here].

# The additional brackets are so we can see the name of the dataset loaded

# TODO Recording
# - click on the Environment tab and show that there is a variable called
# indian.food

(load("./datasets/indian.food.RData"))

names(indian.food)
indian.food[12:16, c(1, 3, 6)]

# Read files which are embedded in R packages

install.packages("learningr")

english.monarchs <- system.file("extdata",
                                "english_monarchs.csv",
                                package = "learningr")

english.monarchs.df <- read.csv(english.monarchs, 
                                header = TRUE, fill = TRUE)

tail(english.monarchs.df, 10)

# TODO Recording:
# - Expand the Files tab on the RHS (so it is on the bottom right) 
# - It will be open to current folder i.e. Skillsoft/R/code
# - Create a datasets sub-folder under this folder 
# - In a Finder window paste all your datasets into this datasets/ folder
# - Come back to RStudio and show that the datasets can be seen here
# - Hide the Files window so you are now back with just Script and Console

# TODO Recording:
# - Please open the CSV file and show its contents

indian.food.csv <- read.csv("datasets/indian_food.csv", header = TRUE)
names(indian.food.csv)

tail(indian.food.csv[, c("name", "diet", "flavor_profile", "state")])

# TODO Recording:
# - Click on the mtcars.txt file and show its contents

mtcars.txt <- read.delim("datasets/mtcars.txt", sep = "\t")
head(mtcars.txt)

# Read XML files

install.packages("XML")
library(XML)

xml.file <- system.file("extdata", "options.xml", package = "learningr")

r.options <- xmlParse(xml.file)
r.options

xpathSApply(r.options, "//variable[contains(@name, 'defaultPackages')]")
xpathSApply(r.options, "//variable[contains(@name, 'stringsAsFactors')]")

# Read Excel files

# TODO Recording:
# - Please open the Excel file and show its contents (both files)

install.packages("readxl")
library(readxl)

indian.food.xls <- read_excel("./datasets/indian_food.xls")
names(indian.food.xls)

tail(indian.food.xls[, c("name", "diet", "course", "state")])

indian.food.xlsx <- read_excel("./datasets/indian_food.xlsx")
head(indian.food.xlsx[, c("name", "diet", "course", "state", "region")])


# Read JSON file

# TODO Recording:
# - Please open the JSON file and show its contents

install.packages("jsonlite")
library(jsonlite)

placement.data.json <- fromJSON("./datasets/PlacementData.json")
head(placement.data.json)


# Writing data out to files in R (we will write out the mtcars dataset)

# TODO Recording
# - For writing out of files, please keep the Files pane open so we can see each file
# as it is written out

head(mtcars)

save(mtcars, file = "./datasets/mtcars.RData")

# TODO Recording
# - Show the CSV file in the Files tab
# - Go to Finder and open up the CSV file in sublimetext
write.csv(mtcars, file="./datasets/mtcars.csv")

# European format

# TODO Recording
# - Show the CSV file in the Files tab
# - Go to Finder and open up the CSV file in sublimetext
write.csv2(mtcars, file="./datasets/mtcars2.csv")

# Write to an Excel file

install.packages("writexl")
library(writexl)

# TODO Recording
# - Show the Excel file in the Files tab
# - Go to Finder and open up the Excel file in Excel (or Numbers if you do 
# not have Excel)
write_xlsx(mtcars, "./datasets/mtcars.xlsx")

# Writing to a JSON file

# TODO Recording
# - Show the JSON file in the Files tab
# - Go to Finder and open up the JSON file in sublimetext

mtcars.json <- toJSON(mtcars, pretty=TRUE)

mtcars.json

write(mtcars.json, "./datasets/mtcars.json")















