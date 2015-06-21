#####
## Assume full UCU HAR Dataset folder is unzipped to the working directory
## Assume dplyr & reshape2 packages are installed
#####

library(dplyr)
library(reshape2)

## Read files

##read test files
testobvs = read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
testlabels = read.table("./UCI HAR Dataset/test/Y_test.txt")
names(testlabels)[1] = "activitylabels"
testsubjects = read.table("./UCI HAR Dataset/test/subject_test.txt")
names(testsubjects)[1] = "subject_id"
# add labels and subjects onto obvs dataset & add an identifier that this is test data
testdata <- cbind(testobvs, testlabels, testsubjects)
## to test head(testdata)

##read training files
trainobvs = read.table("./UCI HAR Dataset/train/X_train.txt")
trainlabels = read.table("./UCI HAR Dataset/train/Y_train.txt")
names(trainlabels)[1] = "activitylabels"
trainsubjects = read.table("./UCI HAR Dataset/train/subject_train.txt")
names(trainsubjects)[1] = "subject_id"
# add labels and subjects onto obvs dataset  & add an identifier that this is training data
traindata <- cbind(trainobvs, trainlabels, trainsubjects)
## to test head(traindata)

## Merge files
totaldata <- rbind(traindata,testdata)

## extract only the means and standard deviations

##get the names of the variables
vars <- read.table("./UCI HAR Dataset/features.txt")
varnames <- make.names(vars[,2], unique=TRUE)
## label the columns in totaldata with the varnames
colnames(totaldata) <- c(varnames, "activity_id", "subject_id")
## only take the variables that calculate the mean or the standard deviation (using match)
## I have removed meanFreq and the angle calculations, as they are not pure mean/std calculations, as per the README file in UCI HAR Dataset
## keep activity/subject data
tdsubset <- select(totaldata,matches("mean|std",ignore.case=TRUE),-matches("meanFreq|angle",ignore.case=TRUE), activity_id,subject_id  )

  
## label activities correctly
## Note: I used subsetting here on the advice of TA David Hood,
## as it was the most simple (though not most elegant) way to do it.
tdsubset$activitylabel[tdsubset$activity_id == 1] <- "WALKING"
tdsubset$activitylabel[tdsubset$activity_id == 2] <- "WALKING_UPSTAIRS"
tdsubset$activitylabel[tdsubset$activity_id == 3] <- "WALKING_DOWNSTAIRS"
tdsubset$activitylabel[tdsubset$activity_id == 4] <- "SITTING"
tdsubset$activitylabel[tdsubset$activity_id == 5] <- "STANDING"
tdsubset$activitylabel[tdsubset$activity_id == 6] <- "LAYING"
##get rid of the activity_id
tdsubset <- select(tdsubset,-activity_id)

## label the dataset descriptively (step already done as part of extracting only the mean and std columns)
## I have used the same naming conventions as the features.txt file, as they seemed clear enough to me.
## further descriptions of variables are included in the README, but they are descriptive of what's being measured:
## Time or Fourier Frq  - t/f
## Body/Gravity
## Accelerometer or Gyroscope - Acc/Gyro
## Jerk (Jerk)
## Magnitude (Mag)
## Axis - X Y or Z
## Measure - Mean/SD


## creates a independent tidy data set with the average of each variable for each activity and each subject.
tdmelt <-melt(tdsubset, id=c("activitylabel", "subject_id"))
tdcast <- dcast(tdmelt, activitylabel + subject_id ~ variable, mean)


