# Getting and Cleaning Data Course Project

## Introduction
This repository is hosting the R code for the assignment of the DataScience Course Project as part of the "Getting and Cleaning Data" course.

## Course Assignment
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Execution and Files
### Data for the Project
The data set has been stored in `/Data/UCI HAR Dataset/` directory (if does not exist, it is created during execution).

### R script Run_Analysis.R abstract:
The `R run_analysis.R` script does the following: 

1. Get the data set required by the project
2. Prepare and clean data
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
3. Save the independent tidy data set, for which the file `tidy.csv` is created, under `/data/` folder, storing the mean and standard deviation average per activity & subject for a later analysis.

### Structure, contents,and layout of the tidy.csv output data file
The `CodeBook.md` file also uploaded to this repository describes the variables, the data, and the work that has been performed to clean up the data.

