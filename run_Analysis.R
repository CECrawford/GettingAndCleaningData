###################################################################################################################
# 1. Goal is to merge the training and the test sets to create one data set.
# Script assumes that the files have been downloaded and unpacked to a folder named "UCI HAR Dataset"
# in the current working directory
###################################################################################################################

library(dplyr)
library(stringr)
library(tidyr)

#load features and activities files
features <- read.csv("./UCI HAR Dataset/features.txt", sep = "", header = FALSE,
                     col.names = c("featureNumber", "featureLabel"))

activities.labels <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", stringsAsFactors = FALSE, 
                              header = FALSE,  col.names = c("activityNumber", "activity"))

# load training set files

subject.train <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE, col.names = c("subject"))
X.train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, check.names = FALSE, col.names = features$featureLabel)
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE, col.names = c("activityNumber"))

# load test set files

subject.test <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE, col.names = c("subject"))
X.test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, check.names = FALSE, col.names = features$featureLabel)
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE, col.names = c("activityNumber"))


#combine all files together into 1 data.frame
combined.raw <- rbind(data.frame(subject.train, X.train, y_train, check.names = FALSE), data.frame(subject.test, X.test, y_test, check.names = FALSE) )

#######################################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement
# Based on reading the features_info.txt, the means are in columns which include the string "mean()"
# The standard deviations are in columns which include the string "std()"
# meanFreq() values are weighted averages, so do are not included
#######################################################################################################

#select all columns with mean or std 

# there are some duplicate column names, remove first.  These are ones we don't need
# as they are the bandsEnergy ones
idx.duplicates <- which(duplicated(names(combined.raw)))
combined.extract <- combined.raw[, -idx.duplicates]

combined.extract <- select(combined.extract, contains("subject"), contains("activityNumber"),
                           contains("mean()"), contains("std()"))
                           

#######################################################################################################
# 3. Make the dataset uses descriptive activity names to name the activities in the data set

#######################################################################################################
#update activity with the label for clarity
combined.temp <- merge(combined.extract, activities.labels, by = "activityNumber")

#drop activityNumber column 
combined.extract <- combined.temp[,-1]

#######################################################################################################
# 4. Label the dataset with descriptive variable names

#######################################################################################################

# put names in temp variable
names.temp <- names(combined.extract)

#replace tBody with timeBody
names.temp <- str_replace_all(names.temp, "tBody", "timeBody")
#replace fBody with frequencyBody
names.temp <- str_replace_all(names.temp, "fBody", "frequencyBody")
#replace tGravity with timeGravity
names.temp <- str_replace_all(names.temp, "tGravity", "timeGravity")
#replace Acc with Accelerometer
names.temp <- str_replace_all(names.temp, "Acc", "Accelerometer")
#replace Gyro with Gyroscope
names.temp <- str_replace_all(names.temp, "Gyro", "Gyroscope")
#replace Mag with Magnitude
names.temp <- str_replace_all(names.temp, "Mag", "Magnitude")
#remove ()
names.temp <- str_replace_all(names.temp, "\\(\\)", "")



names(combined.extract) <- names.temp

#######################################################################################################
# 5. Label the dataset with descriptive variable names
# From the data set in step 4, create a second, independent tidy data set with the average
# of each variable for each activity and each subject.
#######################################################################################################


temp.pivot <- pivot_longer(combined.extract, -c("subject", "activity"), names_to = "measurement", values_to = "value")
grouped.Pivot <- group_by(temp.pivot, subject, activity, measurement)
tidy.Result <- summarise(grouped.Pivot, mean = mean(value, na.rm = TRUE))

write.table(tidy.Result, file="tidy.Result.txt", row.name=FALSE)
