Getting-and-Cleaning-Data
=========================

Course Project


Overview
-----------
This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis. 
A full description of the data used in this project can be found at The UCI Machine Learning Repository

Project Summary
------------------
You should create one R script called run_analysis.R that does the following.

1)	Merges the training and the test sets to create one data set.

2)	Extracts only the measurements on the mean and standard deviation for each measurement.

3)	Uses descriptive activity names to name the activities in the data set

4)	Appropriately labels the data set with descriptive activity names.

5)	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Steps to work on this course project
--------------------------------------
1)	Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
2)	Put run_analysis.R in the parent folder of UCI HAR Dataset
3)	Update the ‘run_analysis.R’ file to change the current working directory (setwd(path)) to the path where you unzipped the dataset.
4)	 Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.

Dependencies
--------------
‘run_analysis.R’ file will help you to install the dependencies automatically. It depends on reshape2.

run_analysis.R
-----------------
The cleanup script (run_analysis.R) does the following:
1)	Merges the training and the test sets to create one data set.
2)	Extracts only the measurements on the mean and standard deviation for each measurement.
3)	Uses descriptive activity names to name the activities in the data set
4)	Appropriately labels the data set with descriptive activity names.
5)	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Running the script
-------------------
To run the script, source run_analysis.R 
source("run_analysis.R")


Process
-----------
1)	Load both test and train data
2)	Load the features and activity labels.
3)  Merge the test and train data to prepare a final dataset.
4) 	Extract the mean and standard deviation column names and data.
5)	Merge the activity label and final dataset to get the activity names.
6)	Rename the column names to get descriptive activity names.
7)	Melt the final data to cast the tidy dataset to get the average of each variable as desired and write the resultant dataset obtained to file.

Cleaned Data
--------------
The resulting clean dataset is in this repository at:  
tidy_data.txt
It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.

Additional Information
-------------------------
You can find additional information about the variables, data and transformations in the CodeBook.MD file.

