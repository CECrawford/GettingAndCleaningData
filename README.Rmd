---
title: "Cleaning and Getting Data Course Project - readme"
author: "CE Crawford"
date: "24/12/2019"
output:
  html_document:
    keep_md: yes
---


## Overview

This project is an analysis of accelerometer data collected from the project as described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Contents

* README.md - this file
* codebook.md - describes the data and what has been done to the data during the analysis
* tidy.Result.txt - output of the script
* run_Analyis.R - script file which does the data processing

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How to : guide
1. Ensure that you unpack the file getdata_projectfiles_UCI HAR Dataset.zip to a folder called 
"UCI HAR Dataset" in your R working directory.

2. Run the run_Analysis.R script

3. If you would like to view the output file from within R, you can read it back into R using the
following script:
```r
data <- read.table("tidy.Result.txt", header = TRUE)
View(data)
```
