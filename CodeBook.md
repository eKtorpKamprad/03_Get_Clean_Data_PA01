## Original (raw) data from [UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/index.html) 
The original data set is the result of an experiment carried out with a group of 30 volunteers within an age bracket 
of 19 to 48 years. 

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded 
to label the data manually, resulting in a measurement vector with 561 features.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

For detailed description of the original dataset, refer to `README.txt` and `features_info.txt` bundeled with the [original 
data set zip archive] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

## Work/Transformations performed to cleanup the data

### 1. Get the data set required by the project
The original (raw) data set has been downloaded and unziped in the `/Data/UCI HAR Dataset/` directory.

### 2. Prepare and clean data
#### 1. Merges the training and the test sets to create one data set.
Reading first all the files in original data set required for this project by using `read.table()` functions, then information is merged
at a first steep from `training` and `test` paired files by using `rbind()` function. 

Secondly variable names from `features.txt` file are set in the merged data set, replacing default feature names.
#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
From the total of 561 variables, only a subset of 66 of them that contains in feature name `mean` or `std` in their 
naming convention will be maintined.
```
        datasetColumns  <- names(dataset)
        SubsetFeatures  <- datasetColumns[grep("mean\\(\\)|std\\(\\)", datasetColumns)]
        RequiredNames   <- c(as.character(SubsetFeatures), "Subject", "Activity")
        dataset         <- subset(dataset,select=RequiredNames)
```        
#### 3. Uses descriptive activity names to name the activities in the data set
Activity names are set mapping activity id available in merged subset by using the `activity_labels.txt` file available 
in original data set.
#### 4. Appropriately labels the data set with descriptive variable names. 
```
        names(dataset) <- gsub("^t", "time", names(dataset))
        names(dataset) <- gsub("^f", "frequency", names(dataset))
        names(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
        names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
        names(dataset) <- gsub("Mag", "Magnitude", names(dataset))
        names(dataset) <- gsub("BodyBody", "Body", names(dataset))
``` 
#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
`SD()` and `mean()` are used through `lapply()` to obtain averaged values per activity and subject:
```
tidy    <- dat[,lapply(.SD,mean),by="Activity,Subject"]
```
### 3. Save the independent tidy data set 
A file `tidy.csv` is created under `/data/` folder storing independent tidy data set content.

## Tidy data file
### Overview
This `tidy.csv` file contains the *averaged mean and standard deviation values* per activity and subject from original (raw) 
data set, resulting a total of 180 records (6 activities x 30 subjects) with a total of 68 averaged variables.

### Attributes information
For each record in the `tidy.csv` file, it is being provided:
* Its activity label (one out of the six activities above listed)
* An identifier of the subject who carried out the experiment (ranked from 1 till 30)
* 66 features with the different averaged mean and standard deviation values

### Variable names
* timeBodyAccelerometer-mean()-X
* timeBodyAccelerometer-mean()-Y
* timeBodyAccelerometer-mean()-Z
* timeBodyAccelerometer-std()-X
* timeBodyAccelerometer-std()-Y
* timeBodyAccelerometer-std()-Z
* timeGravityAccelerometer-mean()-X
* timeGravityAccelerometer-mean()-Y
* timeGravityAccelerometer-mean()-Z
* timeGravityAccelerometer-std()-X
* timeGravityAccelerometer-std()-Y
* timeGravityAccelerometer-std()-Z
* timeBodyAccelerometerJerk-mean()-X
* timeBodyAccelerometerJerk-mean()-Y
* timeBodyAccelerometerJerk-mean()-Z
* timeBodyAccelerometerJerk-std()-X
* timeBodyAccelerometerJerk-std()-Y
* timeBodyAccelerometerJerk-std()-Z
* timeBodyGyroscope-mean()-X
* timeBodyGyroscope-mean()-Y
* timeBodyGyroscope-mean()-Z
* timeBodyGyroscope-std()-X
* timeBodyGyroscope-std()-Y
* timeBodyGyroscope-std()-Z
* timeBodyGyroscopeJerk-mean()-X
* timeBodyGyroscopeJerk-mean()-Y
* timeBodyGyroscopeJerk-mean()-Z
* timeBodyGyroscopeJerk-std()-X
* timeBodyGyroscopeJerk-std()-Y
* timeBodyGyroscopeJerk-std()-Z
* timeBodyAccelerometerMagnitude-mean()
* timeBodyAccelerometerMagnitude-std()
* timeGravityAccelerometerMagnitude-mean()
* timeGravityAccelerometerMagnitude-std()
* timeBodyAccelerometerJerkMagnitude-mean()
* timeBodyAccelerometerJerkMagnitude-std()
* timeBodyGyroscopeMagnitude-mean()
* timeBodyGyroscopeMagnitude-std()
* timeBodyGyroscopeJerkMagnitude-mean()
* timeBodyGyroscopeJerkMagnitude-std()
* frequencyBodyAccelerometer-mean()-X
* frequencyBodyAccelerometer-mean()-Y
* frequencyBodyAccelerometer-mean()-Z
* frequencyBodyAccelerometer-std()-X
* frequencyBodyAccelerometer-std()-Y
* frequencyBodyAccelerometer-std()-Z
* frequencyBodyAccelerometerJerk-mean()-X
* frequencyBodyAccelerometerJerk-mean()-Y
* frequencyBodyAccelerometerJerk-mean()-Z
* frequencyBodyAccelerometerJerk-std()-X
* frequencyBodyAccelerometerJerk-std()-Y
* frequencyBodyAccelerometerJerk-std()-Z
* frequencyBodyGyroscope-mean()-X
* frequencyBodyGyroscope-mean()-Y
* frequencyBodyGyroscope-mean()-Z
* frequencyBodyGyroscope-std()-X
* frequencyBodyGyroscope-std()-Y
* frequencyBodyGyroscope-std()-Z
* frequencyBodyAccelerometerMagnitude-mean()
* frequencyBodyAccelerometerMagnitude-std()
* frequencyBodyAccelerometerJerkMagnitude-mean()
* frequencyBodyAccelerometerJerkMagnitude-std()
* frequencyBodyGyroscopeMagnitude-mean()
* frequencyBodyGyroscopeMagnitude-std()
* frequencyBodyGyroscopeJerkMagnitude-mean()
* frequencyBodyGyroscopeJerkMagnitude-std()
* Subject
* Activity


