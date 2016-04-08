library(dplyr)
library(lubridate)
library(ggplot2)
library(reshape2)

##Read in all datasets

##Reading in activity labels and setting column names
activity_labels <- read.table("./activity_labels.txt", col.names = c("activity_id",
                                                                     "activity_name"))

##Reading in features table and creating feature_names vector
features <- read.table("features.txt")
feature_names <- features[,2]

##Reading in test data and setting column names
##to match feature names
testdata <- read.table("./X_test.txt")
colnames(testdata) <- feature_names

##Reading in training data and setting column names
##to match feature names
traindata <- read.table("./X_train.txt")
colnames(traindata) <- feature_names

##Reading in subject_id table and setting column name
##to subject_id
test_subject_id <- read.table("./subject_test.txt")
colnames(test_subject_id) <- "subject_id"

## Reading in activity table and setting column name
test_activity_id <- read.table("./y_test.txt")
colnames(test_activity_id) <- "activity_id"

## Reading the training subjects' id and labeling column
train_subject_id <- read.table("./subject_train.txt")
colnames(train_subject_id) <- "subject_id"

## Reading the activity id's of the training data and label
##the dataframe's columns
train_activity_id <- read.table("./y_train.txt")
colnames(train_activity_id) <- "activity_id"

##column binding test data into one dataset
total.test.data <- cbind(test_subject_id , test_activity_id , testdata)

##column binding training data into one dataset
total.train.data <- cbind(train_subject_id , train_activity_id , traindata)

##combining training and test datasets
complete.data <- rbind(total.test.data, total.train.data)

##Keep only columns that relate to mean or standard deviation
mean_col_idx <- grep("mean",names(complete.data),ignore.case=TRUE)
mean_col_names <- names(complete.data)[mean_col_idx]
std_col_idx <- grep("std",names(complete.data),ignore.case=TRUE)
std_col_names <- names(complete.data)[std_col_idx]
meanstddata <-complete.data[,c("subject_id","activity_id",
                               mean_col_names,std_col_names)]

##Merge mean and std dataset with activites dataset
descrnames <- merge(activity_labels,meanstddata,by.x="activity_id",
                    by.y="activity_id",all=TRUE)

##Melt the dataset with the descriptive activity names for better handling
data_melt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))

##Cast the melted dataset according to  the average of each variable
##for each activity and each subject
mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)

## Create a file with the new tidy dataset
write.table(mean_data,"./tidy_movement_data.txt")


