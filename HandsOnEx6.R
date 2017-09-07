install.packages("RCurl")
install.packages("XML")
library(RCurl)
library(XML)
data <- getURL("http://stats.espncricinfo.com/ci/content/records/284248.html")
dataTable <- readHTMLTable(data, header = T, which = 1, stringAsFactors = F)
View(dataTable)

# Question 1 
# Plot 5 highest runs
#Sorting the data, if it is not already sorted
order(dataTable$Runs) 
Top5Runs <- dataTable[1:5,]
Top5Runs$Year <- factor(Top5Runs$Year)
Top5Runs$Runs <- as.numeric(levels(Top5Runs$Runs))[Top5Runs$Runs]

#Plotting the graph
library(ggplot2)

ggplot(data=Top5Runs, aes(x=Top5Runs$Year, y=Top5Runs$Runs)) +
  geom_bar(stat="identity", width = 0.5) +
  geom_text(aes(label=Top5Runs$Runs), vjust=1.6, color="white", size=3.5)

# Question 2
# Counting the frequency
players=plyr::count(dataTable, 'Player')

# Printing the name of the player with the highest frequency value
print(players[which.max(players[,2]),])

# Question 3
# Splitting Player Names into two columns

dataTable$Player = as.character(dataTable$Player)

dataTable = cbind(dataTable, stringr::str_split_fixed(dataTable$Player, " ", 3)) #PA de Silva string causing issues
colnames(dataTable)[18] = "Country"
countryContri = plyr::count(dataTable, 'Country')
contribution = countryContrit$freq*100/sum(countryContri$freq)
countryContri = cbind(countryContri,contribution)