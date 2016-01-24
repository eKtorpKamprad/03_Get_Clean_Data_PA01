#-----------------------------------------------------------------------------#
# Name:         run_analysis.R                                                #
# Purpose:      R code related to the 'Getting & Cleaning Data' Course        #
#               Project with the purpose of demonstrating abilities learned   #
#               to collect, work with, and clean a datasets.                  #
#                                                                             #        
# Autor:        Manuel Ortiz                                                  #
# Date:         24/01/2016                                                    #
#-----------------------------------------------------------------------------#
# PROJECT ASIGNMENT: creates an R script called run_analysis.R that does the  #
# following:                                                                  #                
#                                                                             #                                        
#   1. Merges the training and the test sets to create one data set.          #
#   2. Extracts only the measurements on the mean and standard deviation for  #  
#      each measurement.                                                      #
#   3. Uses descriptive activity names to name the activities in the data set.#
#   4. Appropriately labels the data set with descriptive activity names.     #
#   5. Creates a second, independent tidy data set with the average of each   #
#      variable for each activity and each subject.                           #        
#-----------------------------------------------------------------------------#
# FUNCTIONS:                                                                  #
#   > downloadData()                                                          #
#   > mergeData()                                                             #
#   > extractData()                                                           #
#   > setActivityNames()                                                      #
#   > renameVariables()                                                       #
#   > createsTidy()                                                           #
#-----------------------------------------------------------------------------#

library(data.table)


downloadData = function(fileUrl,dataset2Path){
        message("   0. Preparation of the data required by the project")
        # Check if data directory exists, if not create it
        if (!file.exists(datasetPath)){
                message("creating data folder...")
                dir.create(datasetPath, showWarnings = FALSE, recursive = TRUE)
        }
        datasetName    <- "UCI_HAR_Dataset.zip"
        dataset        <- file.path(datasetPath,datasetName)
        message("      > downloading data...")
        download.file(fileUrl,dataset)
        message("      > unziping data...")
        unzip(zipfile=dataset,exdir=datasetPath)
}

mergeData = function(path){
        message("   1. Merges the training and the test sets to create one ") 
        message("      data set")
        message("      > loading data...")
        TestActivity    <- read.table(file.path(path, "test", 
                                                "Y_test.txt"))
        TrainActivity   <- read.table(file.path(path, "train", 
                                                "Y_train.txt"))
        TestSet         <- read.table(file.path(path, "test", 
                                                "X_test.txt"))
        TrainSet        <- read.table(file.path(path, "train", 
                                                "X_train.txt"))
        TestSubject     <- read.table(file.path(path, "test", 
                                                "subject_test.txt"))
        TrainSubject    <- read.table(file.path(path, "train", 
                                                "subject_train.txt"))
        message("      > merging data...")
        MergedActivity  <- rbind(TestActivity, TrainActivity)
        MergedSet       <- rbind(TestSet, TrainSet)
        MergedSubject   <- rbind(TestSubject, TrainSubject)
        message("      > setting names to variables...")
        names(MergedSubject)    <- c("Subject")
        names(MergedActivity)   <- c("Activity")
        Features        <- read.table(file.path(path, "features.txt"))
        names(MergedSet)        <- Features$V2
        dataset         <- cbind(MergedSet,cbind(MergedSubject, MergedActivity))
        dataset
}

extractData = function(dataset, path){
        message("   2. Extracts only the measurements on the mean and standard")
        message("      deviation for each measurement")
        message("      > extracting mean & std measurements...")
        datasetColumns  <- names(dataset)
        SubsetFeatures  <- datasetColumns[grep("mean\\(\\)|std\\(\\)", 
                                               datasetColumns)]
        RequiredNames   <- c(as.character(SubsetFeatures), "Subject", 
                                                           "Activity")
        dataset         <- subset(dataset,select=RequiredNames)
        dataset
}

setActivityNames = function(dataset, path){
        message("   3. Uses descriptive activity names to name the activities")
        message("      in the data set")
        message("      > setting activity names")
        activityLabels  <- read.table(file.path(path, "activity_labels.txt"))
        activityId = 1
        for (activityLabel in activityLabels$V2){
                dataset$Activity <- gsub(activityId, activityLabel, 
                                         dataset$Activity)
                activityId <- activityId + 1
        }
        dataset
}

renameVariables = function(dataset){
        message("   4. Appropriately labels the data set with descriptive") 
        message("      activity names")        
        message("      > renaming dataset labels...")
        names(dataset) <- gsub("^t", "time", names(dataset))
        names(dataset) <- gsub("^f", "frequency", names(dataset))
        names(dataset) <- gsub("Acc", "Accelerometer", names(dataset))
        names(dataset) <- gsub("Gyro", "Gyroscope", names(dataset))
        names(dataset) <- gsub("Mag", "Magnitude", names(dataset))
        names(dataset) <- gsub("BodyBody", "Body", names(dataset))
        dataset
}

createsTidy = function(dataset){
        message("   5. Creates a second, independent tidy data set with the ")
        message("      average of each variable for each activity and each ")
        message("      subject") 
        message("      > Calculating and saving average mean & std values...")
        dat     <- data.table(dataset)
        tidy    <- dat[,lapply(.SD,mean),by="Activity,Subject"]
        tidy
}


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datasetPath     <- "data/data_science_specialization/03_Get_Clean_Data_PA01"
downloadData(fileUrl,datasetPath)
path    <- file.path(datasetPath , "UCI HAR Dataset")
dat     <- mergeData(path)
dat     <- extractData(dat, path)
dat     <- setActivityNames(dat, path)
dat     <- renameVariables(dat)
tidy    <- createsTidy(dat) 

dataset2Path    <- "Data Science Specialization/03_Get_Clean_Data_PA01"
dataset2Name    <- "tidy.txt"
dataset2        <- file.path(dataset2Path,dataset2Name)

write.table(tidy,dataset2,sep=",",row.names=FALSE)
message("      > Process Finished!")
message("      > Tidy data can be found in file: ")
message("        \"",paste(getwd(),dataset2,sep=""))
