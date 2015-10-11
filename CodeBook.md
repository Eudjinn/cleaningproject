# The Code Book for "Getting and Cleaning Data" course project
## Introduction
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
This is done by the function "runAnalysis()" which is implemented in the script: "run_analysis.R". 

## RAW Data 
[The RAW data - zip archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
For simplicity this file was donwloaded manually, unpacked and included in repository in the folder "UCI HAR Dataset". 

### Short summary about the RAW data
#### For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment. 
#### The dataset includes the following files:
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels. 
#### The following files are available for the train and test data. Their descriptions are equivalent.  
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  
The contents of the following folders are not used in this analysis and its description will not be porovided in this document.
* 'train/Inertial Signals/
* 'test/Inertial Signals/ 

### Tidy data set creation steps
#### 1. Download and unzip the RAW data. 
It is expected by the run_analysis.R that the data is unzipped into working directory where the script is located.   
Next steps are performed by the run_analysis.R script automatically.

#### 2. Read the contents of the following files of the RAW data: 
Read the test set data from: "./UCI HAR Dataset/test/X_test.txt"  
Read the training set data from: "./UCI HAR Dataset/train/X_train.txt"  
Read features names from: "./UCI HAR Dataset/features.txt"  
Read activities labels from: "./UCI HAR Dataset/activity_labels.txt"  
Read activities ids corresponding to measurements in test set from: "./UCI HAR Dataset/test/y_test.txt"  
Read activities ids corresponding to measurements in training set from: "./UCI HAR Dataset/train/y_train.txt"  
Read subject ids corresponding to measurements in test set from: "./UCI HAR Dataset/test/subject_test.txt"  
Read subject ids corresponding to measurements in test set from: "./UCI HAR Dataset/train/subject_train.txt" 

#### 3. Merge the training and the test sets to create one data set.
Features are added as names for the columns of the merged table.
Subject ids and activity ids for each measurement are also added to the table as first two columns. 

#### 4. Extract only the measurements on the mean and standard deviation for each measurement.
In order to select features that we need to include in a tidy data set, their names are transformed according to rules of R using make.names function, as a result we get a unique list of names with special symbols such as parenthesis '()' and comas ',' replaced with dot '.'  
**For example:** *"tBodyAcc-mean()-X"* is converted to *"tBodyAcc.mean...X"*   
There are different measurements which contain the word mean and std (also with upper case firs letter) but in this analysis we are interested only in the result of mean() and std() functions, thus some of the measurements are excluded.  

Measurements selected for further analysis have .mean. and .std. in their names after names transformation.  
Measurements excluded from the resulting tidy data set have different form. Even though some of them contain "Mean" or "Std" in their names, they are not a result of mean() and std() applied to primary measurements.  
**For example:** feature names representing a result of the *angle* function with *gravityMean* as a parameter is excluded.
Features with *meanFreq* in their names are excluded too.  
As a result, 66 features has been selected for further analysis.  

#### 5. Replace activity ids with descriptive activity names to name the activities in the data set.
This is done by joining table with measurements with the table containing activity lables by *activityId*   

#### 6. Appropriately label the data set with descriptive variable names. 
After filtering out feature names, we remove all the dots '.' from their names and make the first letter of the word "mean" and "std" in the upper case.  
**For example:** *"tBodyAcc.mean...X"* is converted to *"tBodyAccMeanX"*  

#### 7. From the data set formed on the previous step, a second, independent tidy data set is created with the average of each variable for each activity and each subject. 
In order to reflect the fact that new dataset contains the average of the measurements, a suffux "Avg" is added to feature names.  

### Tidy data description
Here is a list of columns in the tidy data set:
"subjectId" - the identifier of a person who carried the device while gathering measurements.  
"activityName" - the name of the activity, one of the following: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"  
The rest of the columns listed below contain average measurements per subject and activity containing numeric values (double):  
"tBodyAccMeanXAvg"   
"tBodyAccMeanYAvg"  
"tBodyAccMeanZAvg"  
"tBodyAccStdXAvg"  
"tBodyAccStdYAvg"  
"tBodyAccStdZAvg"  
"tGravityAccMeanXAvg"  
"tGravityAccMeanYAvg"  
"tGravityAccMeanZAvg"  
"tGravityAccStdXAvg"  
"tGravityAccStdYAvg"  
"tGravityAccStdZAvg"  
"tBodyAccJerkMeanXAvg"  
"tBodyAccJerkMeanYAvg"  
"tBodyAccJerkMeanZAvg"  
"tBodyAccJerkStdXAvg"  
"tBodyAccJerkStdYAvg"  
"tBodyAccJerkStdZAvg"  
"tBodyGyroMeanXAvg"  
"tBodyGyroMeanYAvg"  
"tBodyGyroMeanZAvg"  
"tBodyGyroStdXAvg"  
"tBodyGyroStdYAvg"  
"tBodyGyroStdZAvg"  
"tBodyGyroJerkMeanXAvg"  
"tBodyGyroJerkMeanYAvg"  
"tBodyGyroJerkMeanZAvg"  
"tBodyGyroJerkStdXAvg"  
"tBodyGyroJerkStdYAvg"  
"tBodyGyroJerkStdZAvg"  
"tBodyAccMagMeanAvg"  
"tBodyAccMagStdAvg"  
"tGravityAccMagMeanAvg"  
"tGravityAccMagStdAvg"  
"tBodyAccJerkMagMeanAvg"  
"tBodyAccJerkMagStdAvg"  
"tBodyGyroMagMeanAvg"  
"tBodyGyroMagStdAvg"  
"tBodyGyroJerkMagMeanAvg"  
"tBodyGyroJerkMagStdAvg"  
"fBodyAccMeanXAvg"  
"fBodyAccMeanYAvg"  
"fBodyAccMeanZAvg"  
"fBodyAccStdXAvg"  
"fBodyAccStdYAvg"  
"fBodyAccStdZAvg"  
"fBodyAccJerkMeanXAvg"  
"fBodyAccJerkMeanYAvg"  
"fBodyAccJerkMeanZAvg"  
"fBodyAccJerkStdXAvg"  
"fBodyAccJerkStdYAvg"  
"fBodyAccJerkStdZAvg"  
"fBodyGyroMeanXAvg"  
"fBodyGyroMeanYAvg"  
"fBodyGyroMeanZAvg"  
"fBodyGyroStdXAvg"  
"fBodyGyroStdYAvg"  
"fBodyGyroStdZAvg"  
"fBodyAccMagMeanAvg"  
"fBodyAccMagStdAvg"   
"fBodyBodyAccJerkMagMeanAvg"  
"fBodyBodyAccJerkMagStdAvg"  
"fBodyBodyGyroMagMeanAvg"  
"fBodyBodyGyroMagStdAvg"  
"fBodyBodyGyroJerkMagMeanAvg"  
"fBodyBodyGyroJerkMagStdAvg" 