#Setting the directory
setwd("C:/YYYYYY/data_2017")
getwd()

#Reading the csv file
oecdData <- read.csv("DP_LIVE_02072017055613917.csv")

#Finding the total number of columns in the file
ncol(oecdData)

#Removing the last variable
oecdData <- oecdData[,-c(8)]
View(oecdData)

#Installing the required packages
install.packages("RCurl")
install.packages("XML")
library(RCurl)
library(XML)

#Getting the URL
cricket <- getURL("https://en.wikipedia.org/wiki/India%E2%80%93Pakistan_cricket_rivalry")
cricketTable <- readHTMLTable(cricket, header = T, which = 2, stringAsFactors = F )
View(cricketTable)

#Calling the row and column for the number of ODI matches won by India
IndiaWonMatches = cricketTable[3,3]
View(IndiaWonMatches)
