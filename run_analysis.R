##########################################################################################################
#  Getting and Cleaning data - Project
#
# runAnalysis.r File
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################


### install and use reshape2 package that will help in transforming data for preparing tidy data set
#
## functions used:
## 1) melt : to convert wide-format data and melt it into long-format data.
## 2) dcast : it takes long-format data and casts it into wide-format data, 
##            used to cast molten data frame into data frame output
#
##########################################################################################################


if (!require("reshape2")) {
  install.packages("reshape2")
}

require("reshape2")


# set working directory to the location where the UCI HAR Dataset was unzipped
setwd('E:/UCI HAR Dataset/');


##### Step 1 - Merge the training and test data sets

## Read data from files
# read features.txt
features = read.table('features.txt', header = FALSE);
# read activity_labels.txt
activityLabel = read.table('activity_labels.txt', header = FALSE);


## Read training data
# read subject_train.txt
subjectTrain = read.table('train/subject_train.txt', header = FALSE);
# read x_train.txt
xTrain = read.table('train/x_train.txt', header = FALSE);
# read y_train.txt
yTrain = read.table('train/y_train.txt', header = FALSE);

# Assign column names to data read above
colnames(activityLabel) = c('activityId','activity');
colnames(subjectTrain) = "subjectId";
colnames(xTrain) =features[,2];
colnames(yTrain)="activityId";

# create final training set by merging  yTrain, subjectTrain and xTrain
trainingData = cbind(yTrain, subjectTrain, xTrain);


## Read test data
# read subject_test.txt
subjectTest = read.table('test/subject_test.txt', header = FALSE);
# read x_test.txt
xTest = read.table('test/x_test.txt', header = FALSE);
# read y_test.txt
yTest = read.table('test/y_test.txt', header = FALSE);

# Assign column names to test data read above
colnames(subjectTest) = "subjectId";
colnames(xTest) =features[,2];
colnames(yTest)="activityId";

# create final test data set by merging  yTest, subjectTest and xTest
testData = cbind(yTest, subjectTest, xTest);


## Combine training and test data to create complete data set named compData
compData = rbind(trainingData, testData);

## create vector from column names, which will be used to select desired mean() & stddev()
colNames = colnames(compData);


##### Step 2 - Extract mean and standard deviation

# Create a reqFieldVector that contains TRUE values for the ID,mean() & stddev() columns and FALSE for others.
# use grepl for pattern matching. Keep activityId, subjectId, and filter mean and std from remaining column names stored in colNames

reqFieldVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | 
                   + grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) &
                 + !grepl("mean..-",colNames) | grepl("-std..",colNames) &
                   + !grepl("-std()..-",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
finalData = compData[reqFieldVector==TRUE];


##### Step 3 - Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityLabel table to include descriptive activity names like walking, sitting etc.
finalData = merge(activityLabel, finalData, by='activityId',all.x=TRUE);

# Updating the colNames vector to include only the names of new columns - required for further processing
colNames  = colnames(finalData); 


##### Step 4 - Appropriately labels the data set with descriptive variable names. 

# Cleaning up the variable names
# for cleaning names of each variable read all the variables from colName
# use gsub for replacement of pattern matched.
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;


##### Step 5 - Create a second, independent tidy data set with the average of 
##### each variable for each activity and each subject. 

# create list of id variables
idLabels = c("subjectId", "activityId", "activity")

# create subset of remaining variables as measure variables
dataLabels = setdiff(colNames, idLabels)

#melt the final data into long-format data
meltData = melt(finalData, id = idLabels, measure.vars = dataLabels)

# Apply mean function to dataset using dcast function
tidyData = dcast(meltData, subjectId + activity ~ variable, mean)

# write the tidy data set in txt file
write.table(tidyData, file = "./tidy_data.txt")

