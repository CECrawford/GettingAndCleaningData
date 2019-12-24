---
title: "Getting and Cleaning Data Course Project"
author: "CE Crawford"
date: "24 December 2019"
output:
  html_document:
    keep_md: yes
---

## Project Description
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Data processing

**1. Merged the training and the test sets to create one data set.**

The input files consisted of 2 main sets, training and test sets.
In each case there were 3 main files of interest: training/test set, training/test labels and training/ test subject.  features.txt file and activity_labels.txt files were loaded.
The test and training input files were treated as follows:

* loaded the 3 training files into 1 dataframe (used features file data for column labels)
* loaded the 3 test files into 1 data frame ((used features file data for column labels))
* combined the 2 data frames into one data frame using rbind.


**2. Extracted only the measurements on the mean and standard deviation for each measurement.**

Removed columns with duplicate names (none of them were mean or std columns, so were not needed)
created new  combined.extract dataset which contained only columns which were either "subject", "activityNumber" or contained the strings "mean()" or "std().

**3. Used descriptive activity names to name the activities in the data set**
merged combined.extract dataset with the activity.labels dataset to name the activities

**4. Appropriately labels the data set with descriptive variable names.** 

Updated combined.extract with more descriptive names using str_replace_all function.

**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

Used pivot_longer function to create a temporary dataset (temp.pivot) where the measured variables become rows with matching values in a column called "values".

Did a group_by then a summarize to get the average of each variable for each activity and each subject.

Wrote result out to file called tidy.Result.txt

## The tidy file
1. The tidy file "tidy.Result.txt" has 4 columns:
  + subject
  + activity 
  + measurement
  + mean

2. It is tidy because : 
 + Each variable is in 1 column
 + Each different observation of that variable is in a different row.


## Description of the variables in the tidy.Result.txt file
General description of the file 

 * Dimensions - 11880 rows and 4 columns
 * Variables present in the dataset
    + Subject - identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    + Activity - identifies the activity the subject was doing (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone)
    + Measurement - Mean or Std measurements from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
    + Mean - the man of each variable for each activity and each subject.




