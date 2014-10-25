CodeBook for Project in Coursera Getting and Cleaning Data is to clean a data set and submit a tidy data file for later analysis.

The project requirements are outlined in the assignment located at:
https://class.coursera.org/getdata-008/human_grading/view/courses/972586/assessments/3/submissions

The data for the project was found at 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

There are details on the processing in the CodeBook.md located in this repo

The main R script for this project is run_analysis.R. The script assumes that the unzipped file is in the same working directory as the source R script (run_analysis.R).   When unzipped in the working directory, all the files should be setup as required in the script.  It is noted that several of the sub-directories in the data set are not needed.
The needed input files by name (where ./ = working directory) follow.  [NOTE: there are other useful files such as README.txt, but this is a list of files needed for processing]
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt

With the setup as described above, the script should produce a tidy output file named project_tidy.txt.   This file can be read using the R command 
foo_file <- read.table("project_tidy.txt",header=TRUE)

Basic description of the Steps follow
STEP 1: Files are read in and the training and test files are combined using rbind.
STEP 2: The column names are added using the names in the features list (561 features).   A search of the feature names is made to select ONLY those that contain “mean()” and “std()”.   This is done using R grepl.
STEP 3: After combining the subject and activity to the data.frame.   The activity codes (1-6) are replaced with descriptive names.
STEP 4 & 5: The data.frame is grouped by subject and activity and the summarization is done by mean function.   This data is then written using the write.table.


The variables and data used in the run_analysis.R script
NAME                TYPE                 LENGTH     DESCRIPTION
activity_file       character string          1     file name (activity_labels.txt)
features_file       character string          1     file name (features.txt)
test_dir            character string          1     directory name (UCI HAR Dataset/test/)
test_file_activity  character string          1     file name (y_test.txt)
test_file_name      character string          1     file name (X_test.txt)
test_file_subject   character string          1     file name (subject_test.txt)
train_dir           character string          1     directory name (UCI HAR Dataset/test/)
train_file_activity character string          1     file name  (y_train.txt)
train_file_name     character string          1     file name  (X_train.txt)
train_file_subject  character string          1     file name  (subject_train.txt)
UCI_dir             character string          1     directory name (UCI HAR Dataset/)

cc                  character string vector  79     list of mean and std column names
ColName_Vector      character string vector 561     list of all columns 

activities          data.frame                1
activity_in         data.frame                2
combined_activity   data.frame                1
combined_all        data.frame               81
combined_data       data.frame              561     frame of combined data
combined_subject    data.frame                1
features_in         data.frame                2
mean_std_data       data.frame               79
test_activity       data.frame                1
test_data           data.frame              561     initial frame of test data
test_subject        data.frame                1
train_activity      data.frame                1
train_data          data.frame              561     initial frame of training data
train_subject       data.frame                1
combined_shaped     grouped data.frame       81     frame after initial group_by operation
combined_final      grouped data.frame       81     frame after summarise operation

replace_value       FUNCTION                        Function to replace activity value

i                   integer (loop variable)   1     for loop control variable
mean_col            list                     79

find_all_names      logical vector          561     All mean and std columns
find_mean_names     logical vector          561     All mean columns
find_std_names      logical vector          561     All std columns
