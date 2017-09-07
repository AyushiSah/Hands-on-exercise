install.packages("titanic")
install.packages("rpart.plot")
install.packages("randomForest")
install.packages("DAAG")
install.packages("caret")
library(titanic)
library(rpart.plot)
library(gmodels)
library(Hmisc)
library(pROC)
library(ResourceSelection)
library(car)
library(caret)
library(plyr)
library(dplyr)
library(InformationValue)
library(rpart)
library(randomForest)
library("DAAG")

cat("\014") # to Clear the screen

getwd()
setwd("C:/Users/Ayushi/Desktop/MICA/AMMA/titanic") #This working directory is the folder where all the bank data is stored

# Train data
titanic_data_rawdata<-read.csv('train.csv')
titanic_data_impVar <- subset(titanic_data_rawdata, select = c(2,3,5:8,10))
titanic_data_impVar$Survived=as.factor(titanic_data_impVar$Survived)
titanic_data_impVar$Pclass=as.factor(titanic_data_impVar$Pclass)

# To replace NA in Age with mean(age)

titanic_data_impVar$Age[is.na(titanic_data_impVar$Age)] <- mean(titanic_data_impVar$Age, na.rm = T)
summary(titanic_data_impVar)

set.seed(4568)

# Partitioning the data set for GLM

Train <- createDataPartition(titanic_data_impVar$Survived, p=0.7, list=FALSE)
titanic_training <- titanic_data_impVar[ Train, ]
titanic_testing <- titanic_data_impVar[ -Train, ]

titanic_model <- train(Survived ~ Pclass + Sex + Age + SibSp + 
                   Parch + Fare,  data=titanic_training, method="glm", family="binomial")

predictors(titanic_model)
exp(coef(titanic_model$finalModel))

predict(titanic_model, newdata=titanic_testing)
predict(titanic_model, newdata=titanic_testing, type="prob")

titanic_model

varImp(titanic_model)

titanic_model_1 <- train(Survived ~ Pclass + Sex + Age + SibSp +
                           Fare,  data=titanic_training, method="glm", family="binomial")
titanic_model_1

pred = predict(titanic_model, newdata=titanic_testing)
accuracy <- table(pred, titanic_testing[,"Survived"])
sum(diag(accuracy))/sum(accuracy)
accuracy

confusionMatrix(data=pred, titanic_testing$Survived)


#Running K-fold cross validation

ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

titanic_model_kfoldcv <- train(Survived ~ Pclass + Sex + Age + SibSp + 
                           Parch + Fare, data=titanic_data_impVar, method="glm", family="binomial",
                 trControl = ctrl, tuneLength = 5)

pred_kfoldcv = predict(titanic_model_kfoldcv)
confusionMatrix(data=pred_kfoldcv, titanic_data_impVar$Survived)

accuracy_kfoldcv <- table(pred_kfoldcv, titanic_data_impVar[,"Survived"])
sum(diag(accuracy_kfoldcv))/sum(accuracy_kfoldcv)

