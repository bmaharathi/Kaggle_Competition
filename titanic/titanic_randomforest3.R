# load libraries 
library(ggplot2); library(randomForest); library(caret);library(dplyr);library(mice); library(stringr)
#load datasets
training <-read.csv("train.csv", header=TRUE, sep = ",")
testing  <-read.csv("test.csv", header=TRUE, sep = ",")
#combine data sets 
totaldata <- bind_rows(training,testing)

head(totaldata)
#PassengerId Survived Pclass                                                Name    Sex   Age SibSp Parch           Ticket    Fare Cabin Embarked
#(int)    (int)  (int)                                               (chr) (fctr) (dbl) (int) (int)            (chr)   (dbl) (chr)    (chr)
#1           1        0      3                             Braund, Mr.en Harris   male    22     1     0        A/5 21171  7.2500              S
#2           2        1      1 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female    38     1     0         PC 17599 71.2833   C85        C
#3           3        1      3                              Heikkinen, Miss. Laina female    26     0     0 STON/O2. 3101282  7.9250              S
#4           4        1      1        Futrelle, Mrs. Jacques Heath (Lily May Peel) female    35     1     0           113803 53.1000  C123        S
#5           5        0      3                            Allen, Mr. William Henry   male    35     0     0           373450  8.0500              S
#6           6        0      3                                    Moran, Mr. James   male    NA     0     0           330877  8.4583              Q

names(totaldata)
##[1] "PassengerId" "Survived"    "Pclass"      "Name"        "Sex"         "Age"         "SibSp"      
##[8] "Parch"       "Ticket"      "Fare"        "Cabin"       "Embarked"   
## fields with NA value : Age(263) ; Fare (1) ;Embarked 





