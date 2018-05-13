library(data.table)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, "Coursera/project.zip", method ="curl")
unzip(zipfile="Coursera/project.zip")
activityLabels <- fread(file.path(getwd(), "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(getwd(), "UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)
#### Load Training data set 
training <-fread(file.path(getwd(), "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
colnames(training) <- measurements                
trainingy <-fread(file.path(getwd(), "UCI HAR Dataset/train/Y_train.txt"), col.names = "activityName")
subjecttrain <- fread(file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt"), col.names = "subjectnum")
train <- cbind(training,trainingy,subjecttrain)
#### Load Test dataset 
testing <-fread(file.path(getwd(), "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
colnames(testing) <- measurements
testingy <-fread(file.path(getwd(), "UCI HAR Dataset/test/Y_test.txt"), col.names = "activityName")
subjecttest <- fread(file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt"), col.names = "subjectnum")
test <- cbind(training,testingy,subjecttest)
#### binding train and test 
datacombined <- rbind(train, test)
datacombined[["activityName"]] <- factor(datacombined[,activityName], levels = activityLabels[["classLabels"]], labels =activityLabels[["activityName"]])
datacombined[["subjectnum"]] <- as.factor(datacombined[,subjectnum])

####### creating tidy dataset 
library(reshape2)
tidydatareq <- melt(data=datacombined, id=c("activityName", "subjectnum"))
tidydatareq <- dcast(data=tidydatareq, activityName+subjectnum ~ variable, fun.aggregate = mean)
fwrite(tidydatareq, file.path(getwd(),"Coursera/tidydata.csv"))

