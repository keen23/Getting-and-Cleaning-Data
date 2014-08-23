Getting and Cleaning Data Project
Course Project
--------------------------------------

The data source
-----------------
Original data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description of the dataset:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Information
-------------------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/ window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components; therefore a filter with 0.3 Hz cut-off frequency was used.
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The data
-----------
1)  'README.txt'  - contains the description of the experiment.

2)  'features_info.txt'  -  Shows information about the variables used on the feature vector.

3)  'features.txt' - List of all features.

4)  'activity_labels.txt' - Lists the activity id and activity name.
    The label of the activity performed when the corresponding measurements were taken
    o	WALKING (value 1)
    o	WALKING_UPSTAIRS (value 2)
    o	WALKING_DOWNSTAIRS (value 3)
    o	SITTING (value 4)
    o	STANDING (value 5)
    o	LAYING (value 6)

5)	‘train/subject_train.txt’ – The participant ("subject") ID (Subjects on which the test was conducted for obtaining training data set).

6)	'train/X_train.txt’ - Training dataset.

7)  'train/y_train.txt' - Training activity labels.

8)	‘train/subject_train.txt’ – subject on which the test was conducted for obtaining test data set.

9)	'test/X_test.txt' - Test data set.

10)	'test/y_test.txt' -Test activity labels.

Transformation details
-------------------------

There are 5 parts:
1)	Merges the training and the test sets to create one data set.

2)	Extracts only the measurements on the mean and standard deviation for each measurement.

3)	Uses descriptive activity names to name the activities in the data set

4)	Appropriately labels the data set with descriptive activity names.

5)	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How run_analysis.R implements the above steps:

•	Require reshape2 package.

•	Load both test and train data

•	Load the features and activity labels.

•	Merge the test and train data to prepare a final dataset.

•	Extract the mean and standard deviation column names and data.

•	Merge the activity label and final dataset to get the activity names.

•	Rename the column names to get descriptive activity names.

•	Melt and cast the tidy dataset to get the average of each variable as desired and write the resultant dataset obtained to file.




