# GettingandCleaningData #
Repository for Programming Assignment for the Getting and Cleaning Data course of the Data Science Specialisation

##Pre requisites ##
* data downloaded and unzipped into working directory from this location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* dplyr package installed
* reshape2 package installed

##Input Data##
The data were taken from this UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Where a description of how they were gathered is held.

To paraphrase: these are motion-based (accelerometer and gyroscope) data gathered from smartphones while certain physical activities were being performed.
The granularity of input data is one row per observation, with multiple measures.
The links to subject, activity type, measure names, and test/training data are maintained in multiple files.

##Transformation Steps##
* Read in input data for test  (X_test.txt)
* Append subject and activity type to test data (subject_test.txt and Y_test.txt)
* Read in input data for training  (X_train.txt)
* Append subject and activity type to training data (subject_train.txt and Y_train.txt)
* Merge test and training files together
* Add header names for each measure, using features.txt
* Remove unwanted columns (keeping only those that are pure mean and standard deviation calculations)
* Add human-readable activity names in replacement of activity id
* Melt data into variables for each activity and subject combination
* Cast data into a tidy data set with averages for each measure, grouped by activity and subject combination

## Output Data ##
The granularity of output data is one row per observation (activity and subject combination), including the average of each measure. This is a "wide" dataset, but should still classify as tidy as per the discussion here:
https://class.coursera.org/getdata-015/forum/thread?thread_id=27#comment-607 

Please also see the codebook for the description of each of the variables:
https://github.com/delta848/GettingandCleaningData/blob/master/Codebook.md

