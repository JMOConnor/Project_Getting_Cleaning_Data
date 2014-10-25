#Project 
#A full description is available at the site where the data was obtained: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
#
#  run_analysis.R does the following. 
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for 
#     each measurement. 
#  3. Uses descriptive activity names to name the activities in the data 
#     set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data 
#     set with the average of each variable for each activity and each 
#     subject.
library(dplyr)
library(reshape2)

replace_value <- function(x){
        #this function will replace character[integer] with activity character string
        sh <- combined_activity$activity %in% as.character(x)  #find all instances
        tmp <- as.character(activities[x,1])            #get corresponding string
        combined_activity$activity[sh] <<- tmp          #substitute string
}
#This script assumes that it will be run from a working directory that has
# UCI HAR Dataset folder that has files downloaded from the zip file in
# Project assignment
#setwd("/Users/michaeloconnor/Desktop/Coursera/Data_Scientist_Coursera/Course03_Getting_Cleaning_Data/")
UCI_dir = "UCI HAR Dataset/"
train_dir = "UCI HAR Dataset/train/"
test_dir  = "UCI HAR Dataset/test/"
activity_file <- paste(UCI_dir, "activity_labels.txt", sep="")
features_file <- paste(UCI_dir, "features.txt", sep="")
activity_in <- read.table(activity_file, quote="\"")
activities <- activity_in[2]     #just keep the activity strings
features_in <- read.table(features_file, quote="\"")
ColName_Vector <- as.vector(features_in[,2])   #get the column names
#
# Read Training and Test file pairs
# First set the file names that will be read
train_file_name =     paste(train_dir,"X_train.txt", sep="")
train_file_subject =  paste(train_dir,"subject_train.txt", sep="")
train_file_activity = paste(train_dir,"y_train.txt", sep="")
test_file_name =      paste(test_dir,"X_test.txt", sep="")
test_file_subject =   paste(test_dir,"subject_test.txt", sep="")
test_file_activity =  paste(test_dir,"y_test.txt", sep="")
#
train_data     <- read.table(train_file_name, quote="\"")
train_subject  <- read.table(train_file_subject, quote="\"")
train_activity <- read.table(train_file_activity, quote="\"")
#
test_data     <- read.table(test_file_name, quote="\"")
test_subject  <- read.table(test_file_subject, quote="\"")
test_activity <- read.table(test_file_activity, quote="\"")
# Combine Training + Test
combined_data     <- rbind(train_data,test_data)
combined_subject  <- rbind(train_subject,test_subject)
combined_activity <- rbind(train_activity,test_activity)
#change column from integer to character string
combined_activity[[1]] <- as.character(combined_activity[[1]])
#set the column names to the function labels instead of "V1", "V2" etc.
colnames(combined_data) <- ColName_Vector
#Also set the activity and subject column names
colnames(combined_activity) <- "activity"
colnames(combined_subject) <- "subject"
for (i in 1:6)
       {replace_value(i)}       # replacing activity number with activity string

# now find columns containing either "mean()" OR "std()"
# yes, this can be condensed but I prefer to do it this way
find_mean_names <- grepl("mean()",ColName_Vector)
find_std_names  <- grepl("std()",ColName_Vector)
find_all_names  <- find_mean_names | find_std_names
# create new data frame with only mean and std columns
mean_std_data <- subset(combined_data, ,find_all_names)
#Add columns for activity and subject
combined_all <- cbind(mean_std_data, combined_activity, combined_subject)
#At this point Steps 1-4 are completed, now need to tidy
cc <- colnames(combined_all[1:79])  # get the column names for mean
combined_shaped <- group_by(combined_all, subject, activity)
mean_col <- sapply(cc ,function(x) substitute(mean(x), list(x=as.name(x))))
combined_final <- do.call(summarise, c(list(.data=combined_shaped), mean_col))
write.table(combined_final, file ="project_tidy.txt",row.name=FALSE)

#NOTE: to read this file:   foo_file <- read.table("project_tidy.txt",header=TRUE)

