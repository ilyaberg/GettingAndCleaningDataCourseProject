# GettingAndCleaningDataCourseProject
This is a repo for Getting And Cleaning  Data Course Project

This file contains steps to produce a tidy data set from original raw data.

__bold__IMPORTANT!!!
The script run_analysis.R should be run as long as the Samsung data is in your working directory


*Step 1 
Reading column names from feature.txt
Conveting the column names into column names valid for R.
Reading Reading activity names from activity_lables.txt

*Step 2
The following steps apply to training data set

Reading train data set
Assigning descriptive variable names to columns of train data set
Reading subjects for train data set
Reading activities for train data set
Binding together train data set, subjects and activity ids
Merging resulting data set with activity names
Taking only those columns that have unique names.

So, when the above steps are performed, we have a train data set with valid names
of columns that are not repeted, subject id column and activity name.

*Step 3
All the above steps are repeted for test data set.

*Step 4
In this step train data set and test data set are merged.

*Step 5
From the merged data we select only those columns that contain mean and std string.

*Step 6
On this step a tidy data set is created with average values for each variable
for each activity and each subject. This gives a data table with 180 rows and
88 columns.

The resulting data is stored in a file tidy_data_set.txt.




