Project_Getting_Cleaning_Data
=============================
This is the Project for the Coursera class Getting &amp; Cleaning Data

ReadMe version: 10/25/2014
The Project goal for Coursera Getting and Cleaning Data is to clean a data set and submit a tidy data file for later analysis.

The project requirements are outlined in the assignment located at:
https://class.coursera.org/getdata-008/human_grading/view/courses/972586/assessments/3/submissions

The data required for the project was found at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description of the data set is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

There is one R script called run_analysis.R that does the following (excerpt from assignment)
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Notes on those steps:
The script assumes that the unzipped file is in the same working directory as the source R script (run_analysis.R).    It is noted that several of the sub-directories in the data set are not needed.   There are further details on the processing and the script variables in the CodeBook.md.

Running the run_analysis.R script in the working directory in which the required files are located should produce a tidy output file named project_tidy.txt.   This file can be read using the R command: 
foo_file <- read.table("project_tidy.txt",header=TRUE)
