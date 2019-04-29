## Assignment3 - Cleaning the Data
# Download the package
library(data.table)

# Downloading the Data
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
    download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
     unzip("UCI HAR Dataset.zip", exdir = getwd()) }
     
#Loading the data into R
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
str(features)
features <- as.character(features[,2])

# Creating the data
data_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
data.train.activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data.train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data.train <-  data.frame(data.train.subject, data.train.activity, data_train)
names(data.train) <- c(c('subject', 'activity'), features)

data_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data.test <-  data.frame(data.test.subject, data.test.activity, data_test)
names(data.test) <- c(c('subject', 'activity'), features)

## Merging the testing and training data sets
data.all <- rbind(data.train, data.test)

## Extracts only the measurements on the mean and standard_deviation for each measurement
data.mean_sd <- grep('mean|std', features)
#Since the positions of columns found are offset by 2, as we have combined both datasets.
data.sub <- data.all[,c(1,2,data.mean_sd + 2)]

## Use descriptive activity names to name the activities in the data set
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
str(activity.labels)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

## Appropriately label the data set with descriptive variable names
name.dat <- names(data.sub)
name.dat <- gsub("[(][)]", "", name.dat)
name.dat <- gsub("^t", "TimeDomain_", name.dat)
name.dat <- gsub("^f", "FrequencyDomain_", name.dat)
name.dat <- gsub("Acc", "Accelerometer", name.dat)
name.dat <- gsub("Gyro", "Gyroscope", name.dat)
name.dat <- gsub("Mag", "Magnitude", name.dat)
name.dat <- gsub("-mean-", "_Mean_", name.dat)
name.dat <- gsub("-std-", "_StandardDeviation_", name.dat)
name.dat <- gsub("-", "_", name.dat)
names(data.sub) <- name.dat


## Create an independent tidy data set with the average of each variable for each activity and each subject
FinalData <- data.sub %>% group_by(subject, activity) %>% summarise_all(funs(mean))
#Write the data into a text file
write.table(FinalData, "FinalData.txt", row.name=FALSE)
