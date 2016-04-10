## load libraries 
library(ggplot2); library(randomForest); library(caret)

##load datasets
training <-read.csv("train.csv", header=TRUE, sep = ",")
testing  <-read.csv("test.csv", header=TRUE, sep = ",")

##clean datasets
getFeaturedData<- function(inData) {
    inData$Age[is.na(inData$Age)] <- -1
    inData$Fare[is.na(inData$Fare)] <- median(inData$Fare,na.rm = TRUE)
    inData$Embarked[inData$Embarked==''] <- 'S'
    
    feature_fields <- c("Pclass",
                        "Sex",
                        "Age",
                        "SibSp",
                        "Parch",
                        "Fare",
                        "Embarked")
    outData <- inData[,feature_fields]
    return(outData)
}


set.seed(312)

trainData <- cbind(getFeaturedData(training),training$Survived)
names(trainData)[8] <- "Survived"

model1 <- train(factor(Survived) ~., data =trainData , method="rf",proxy=FALSE)
pred1 <- predict(model1,getFeaturedData(testing))
submit <- data.frame(PassengerId = testing$PassengerId)
submit$Survived <- pred1

write.csv(submit, file = "titanic_survive_rf_v01.csv", row.names=FALSE)

