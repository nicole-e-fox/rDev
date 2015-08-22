
## Goals
## 1. each variable should be in one column
## 2. each observation of that variable should be in a diferent row
## 3. include ids to link tables together

## Merges the training and the test sets to create one data set.


## Load packages
library(plyr)
library(reshape2)

## Set working directory
setwd("C:/Users/grrrl/OneDrive/Documents/Academia/courses/03_GettingData/courseProject/UCI HAR Dataset")

## Create working directory ref
wd <- getwd()

## Create list to be populated with dataframes containing data
## in specficied files
dsetin <- list()

## Read in features
dsetin$features <- read.table(paste(wd, "features.txt", sep="/"), col.names=c('id', 'name'), stringsAsFactors=FALSE)

## Read in activity labels
dsetin$activity_labels <- read.table(paste(wd, "activity_labels.txt", sep="/"), col.names=c('id', 'Activity'))

## Read in test data
dsetin$test <- cbind(subject=read.table(paste(wd, "test", "subject_test.txt", sep="/"), col.names="Subject"),
                       y=read.table(paste(wd, "test", "y_test.txt", sep="/"), col.names="Activity.ID"),
                       x=read.table(paste(wd, "test", "x_test.txt", sep="/")))

## Visual sanity check - get familiar with data
##   - expecting to see Activities 1-6 populated for each subject
table(dsetin$test$Subject,dsetin$test$Activity.ID)


## Read in train data
dsetin$train <- cbind(subject=read.table(paste(wd, "train", "subject_train.txt", sep="/"), col.names="Subject"),
                        y=read.table(paste(wd, "train", "y_train.txt", sep="/"), col.names="Activity.ID"),
                        x=read.table(paste(wd, "train", "X_train.txt", sep="/")))

## Visual sanity check
##   - expecting to see Activities 1-6 populated for each subject
table(dsetin$train$Subject,dsetin$train$Activity.ID)

## Select requested variables (mean and standard deviation for each measurement
tidy <- rbind(dsetin$test, dsetin$train)[,c(1, 2, grep("mean\\(|std\\(", dsetin$features$name) + 2)]

## Dynamically assign feature column names
rename.features <- function(col) {
        col <- gsub("tBody", "Time.Body", col)
        col <- gsub("tGravity", "Time.Gravity", col)

        col <- gsub("fBody", "FFT.Body", col)
        col <- gsub("fGravity", "FFT.Gravity", col)

        col <- gsub("\\-mean\\(\\)\\-", ".Mean.", col)
        col <- gsub("\\-std\\(\\)\\-", ".Std.", col)

        col <- gsub("\\-mean\\(\\)", ".Mean", col)
        col <- gsub("\\-std\\(\\)", ".Std", col)

        return(col)
}

## Call in activity names and populate column names
names(tidy) <- c("Subject", "Activity.ID", rename.features(dsetin$features$name[grep("mean\\(|std\\(", dsetin$features$name)]))

## Include descriptive activity names
tidy <- merge(tidy, dsetin$activity_labels, by.x="Activity.ID", by.y="id")

## Reorder columns for easier use / viewing in external tools (e.g. Excel)
tidy.arrange <- tidy[,c(2,69,1,3:68)]

## Sort the data by Subject/Activity for to increase output readability
tidy.sort <- tidy.arrange[order(tidy$Subject,tidy$Activity.ID),]

## Create output data
tidy.output <- tidy.sort[,!(names(tidy.sort) %in% c("Activity.ID"))]

## Create output data - Activity Means by Subject
tidy.output.mean <- ddply(melt(tidy.sort, id.vars=c("Subject", "Activity")), .(Subject, Activity), summarize, MeanSamples=mean(value))

## Output data
write.csv(tidy.output, file = "tidy.txt",row.names = FALSE)

## Output means
write.csv(tidy.output.mean, file = "tidy.output.mean.txt",row.names = FALSE)
