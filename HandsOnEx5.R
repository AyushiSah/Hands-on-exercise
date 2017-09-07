#Setting the directory
setwd("C:/YYYYYY/data_2017")
getwd()

#Getting the data and combining them
emp <- read.csv("Emp.csv")
View(emp)
dept <- read.csv("Dept.csv")
View(dept)
dataset <- merge(emp, dept)
View(dataset)

#Finding average salary by location
averagesalary <- aggregate(dataset$SAL, by = list(dataset$LOC), data = dataset, mean)
View(averagesalary)

# Finding the manager with the most reportees
 emp$MGR <- replace(emp$MGR, 1, 0)
 View(emp$MGR)
 emp$MGRName <-  "Bush"
    q <- 1
for(i in 1:nrow(emp)) {
for(q in 1:nrow(emp))
 { if(emp[i,4] == emp[q,1])
  {emp[i,8] <- emp[q,2]}
}
}
    View(emp$MGRName)
    
#finding the manager with the most reportees
    manager <- subset(dataset, select = c(3, 5))
View(manager)
manager$MGR <- as.factor(manager$MGR)
reportees <- plyr::count(manager, 'MGR')
View(reportees)
print(reportees[which.max(reportees[,2]),])


