## load libraries 
library(ggplot2); library(randomForest); library(caret);library(dplyr);library(mice)

##load datasets
training <-read.csv("train.csv", header=TRUE, sep = ",")
testing  <-read.csv("test.csv", header=TRUE, sep = ",")

##combine data sets 
totaldata <- bind_rows(training,testing)


names(totaldata)
##[1] "PassengerId" "Survived"    "Pclass"      "Name"        "Sex"         "Age"         "SibSp"      
##[8] "Parch"       "Ticket"      "Fare"        "Cabin"       "Embarked"   

## fields with NA value : Age(263) ; Fare (1) ;Embarked 

totaldata[is.na(totaldata$Fare),]$Fare <- median(totaldata$Fare,na.rm=TRUE)
totaldata[totaldata$Embarked=='',]$Embarked <- 'C'

#age correction 
ft_var <- c('PassengerId','Pclass','Sex','Embarked')
totaldata[ft_var] <- lapply(totaldata[ft_var], function(x) as.factor(x))

set.seed(234)
mice_mod <- mice(totaldata[, !names(totaldata) %in% c('PassengerId','Name','Ticket','Cabin','Survived')], method='rf') 
mice_output <- complete(mice_mod)
#replace the age
totaldata$Age <- mice_output$Age

##split data again to train and test
trainfinal <- totaldata[1:891,]
testfinal <- totaldata[892:1309,]


##build prediction model
set.seed(556)
rf_model <- randomForest(factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + 
                             Fare + Embarked,data = trainfinal)
##model error 
plot(rf_model, ylim=c(0,0.36))
legend('topright', colnames(rf_model$err.rate), col=1:3, fill=1:3)

##predict 
prd <- predict(rf_model,trainfinal)
confusionMatrix(prd,trainfinal$Survived)

##predict the final required values 
prdfinal <- predict(rf_model,testfinal)

#write to the file 
submit <- data.frame(PassengerId = testfinal$PassengerId)
submit$Survived <- prdfinal

write.csv(submit, file = "titanic_survive_rf_v02.csv", row.names=FALSE)



