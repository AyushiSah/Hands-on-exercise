#Question 1
#Setting the directory location
setwd("C:/Users/Ayushi/Desktop/MICA/AMMA/student")
getwd()

#Reading the table
students <- read.table("student-mat.csv",sep = ";", header = T)
View(students)

#Keeping relevant variables
maths <- subset(students, select = c(2,12,30:33))

#Finding the average of grades G1, G2 and G3
AverageG1 <- aggregate(maths$G1, by = list(maths$sex), data = maths, mean)
View(AverageG1)
AverageG2 <- aggregate(maths$G2, by = list(maths$sex), data = maths, mean)
View(AverageG2)
AverageG3 <- aggregate(maths$G3, by = list(maths$sex), data = maths, mean)
View(AverageG3)

#Question 2
#Loading the required library
library(dplyr)

#Finding the quartiles
maths$Quartile <-ntile(maths$absences,4)

#Calculating average absenses for different levels of absences
Average_absG1 <- aggregate(maths$G1, by = list(maths$Quartile), data = maths, mean)
print(Average_absG1)
Average_absG2 <- aggregate(maths$G2, by = list(maths$Quartile), data = maths, mean)
print(Average_absG2)
Average_absG3 <- aggregate(maths$G3, by = list(maths$Quartile), data = maths, mean)
print(Average_absG3)
