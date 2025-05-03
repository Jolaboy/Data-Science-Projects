
rm(list = ls())

# The DBI package provides a unified syntax for accessing several DBMSs — 
# currently SQLite, MySQL, MariaDB, PostgreSQL, and Oracle are supported

# To connect to an SQLite database, you must first install and load the 
# DBI package and the backend package RSQLite:

install.packages("DBI")
install.packages("RSQLite")

library(RSQLite)
library(MASS)

# TODO Recording
# - Close the window which opens up when we run this help

?dbConnect

# Connect to an ephemeral in-memory database
conn <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")

dbListTables(conn)

dbWriteTable(conn, "Cars93", Cars93)

dbListTables(conn)

dbListFields(conn, "Cars93")

dbReadTable(conn, "Cars93")

dbGetQuery(conn, "SELECT * FROM Cars93 WHERE DriveTrain = '4WD' LIMIT 5")

dbGetQuery(conn, "SELECT Manufacturer, Model, Price, Origin 
                  FROM Cars93 WHERE Manufacturer = 'Dodge'")

dbGetQuery(conn, "SELECT Manufacturer, Model, Price, Origin, Type
                  FROM Cars93 WHERE Manufacturer = 'Chevrolet'
                  ORDER BY Price")

dbGetQuery(conn, "SELECT Type, AVG(Price) AS avg_price
                  FROM Cars93
                  GROUP BY type
                  ORDER BY Price")


results <- dbSendQuery(conn, "SELECT Manufacturer, Make, Type, Price 
                              FROM Cars93
                              ORDER BY Price")

dbFetch(results)

dbClearResult(results)

results <- dbSendQuery(conn, "SELECT Manufacturer, Make, Type, Price 
                              FROM Cars93
                              ORDER BY Price")

page <- 1

while (!dbHasCompleted(results)) {
  
  chunk <- dbFetch(results, n = 5)
  
  cat("######################", page, "\n")
  print(chunk)
  
  page <- page + 1
  
  if (page > 3) {
    break
  }
}

# You cannot disconnect before you clear results, you get a warning
# "There are 1 result in use. The connection will be released when they are closed"

dbClearResult(results)

dbDisconnect(conn)

# Create a SQLite database backed by a DB file

# TODO Recording
# - Once you run this command, open up the files tab to your code/ folder
# and show that the animals.db file has been created

animals.conn <- dbConnect(RSQLite::SQLite(), dbname = "animals.db")

# Add the rownames as a column in the data frame so it is stored in the 
# underlying table. If we do not do this, the row names are not stored

head(Animals)

Animals$names <- rownames(Animals)

head(Animals)

dbWriteTable(animals.conn, "Animals", Animals, overwrite=TRUE)

dbGetQuery(animals.conn, "SELECT * FROM Animals LIMIT 5")
dbGetQuery(animals.conn, "SELECT COUNT(*) FROM Animals")

# Create another table in the same database

head(snails)

dbWriteTable(animals.conn, "Snails", snails)

dbListTables(animals.conn)

# Inserting and deleting records from tables

dbExecute(animals.conn, "DELETE FROM Animals WHERE brain < 10")

dbGetQuery(animals.conn, "SELECT * FROM Animals WHERE brain < 100")

dbExecute(animals.conn, "INSERT INTO Animals VALUES (1.35, 8.1, 'Mountain beaver')")
dbExecute(animals.conn, "INSERT INTO Animals VALUES (1.04, 5.5, 'Guinea pig')")

dbGetQuery(animals.conn, "SELECT * FROM Animals WHERE brain < 100")

dbDisconnect(conn)

# Note that the tables in the animals.db have been preserved while the tables
# in the in-memory database have not been preserved

another.conn <- dbConnect(RSQLite::SQLite(), dbname = "animals.db")

dbListTables(another.conn)

another.conn <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")

dbListTables(another.conn)







