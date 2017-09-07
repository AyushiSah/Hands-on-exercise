#Installing the required packages
install.packages("data.table")
install.packages("datasets.load")

#Viewing the dataset
View(women)

#Setting the counter to 0
TotWomen <- 0

#Running the for loop
for (i in  1:nrow(women))
  if(women$height[i] > mean(women$height)  & women$weight[i] < mean(women$weight))
  TotWomen= TotWomen+1

#Viewing the number of women with height greater than average and weight less than average
View(TotWomen)

#Installing the required packages
install.packages("RCurl")
install.packages("XML")
library(RCurl)
library(XML)

#Getting the URL from where the table is to be attached
population <- getURL("http://www.worldatlas.com/articles/the-biggest-cities-in-india.html")

#Attaching the table from the URL
PopTable <- readHTMLTable(population, header=T, which=1, stringAsFactors=F)
View(PopTable)
