library(data.table)

# 0. load test and training sets and the activities

# Use the course CDN instead of the original UCI zip file.
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "Data-UCI.zip")
# unzip("Data-UCI.zip")

# Helper function to make filepaths easier
filePath <- function(...) { paste(..., sep = "/") }

# Checking to see if the file is alread downloaded.
downloadDir <- "."

zipFile <- filePath(downloadDir, "Data-UCI.zip")
if(!file.exists(zipFile)) { download.file(url, zipFile, method = "curl") }

# Checking to see if files are already extracted.
dataDir <- "UCI HAR Dataset"
if(!file.exists(dataDir)) { unzip(zipFile, exdir = ".") }

test.data <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
test.data.act <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
test.data.sub <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
train.data <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
train.data.act <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
train.data.sub <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)

# 2. Uses descriptive activity names to name the activities in the data set

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")
test.data.act$V1 <- factor(test.data.act$V1, levels=activities$V1, labels=activities$V2)
train.data.act$V1 <- factor(train.data.act$V1, levels=activities$V1, labels=activities$V2)

# 3. Appropriately labels the data set with descriptive activity names

features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")
colnames(test.data) <- features$V2
colnames(train.data) <- features$V2
colnames(test.data.act) <- c("Activity")
colnames(train.data.act) <- c("Activity")
colnames(test.data.sub) <- c("Subject")
colnames(train.data.sub) <- c("Subject")

# 4. merge test and training sets into one data set, including the activities
test.data <- cbind(test.data, test.data.act)
test.data <- cbind(test.data, test.data.sub)
train.data <- cbind(train.data, train.data.act)
train.data <- cbind(train.data, train.data.sub)
big.data <- rbind(test.data, train.data)

# 5. extract only the measurements on the mean and standard deviation for each measurement
big.data.mean <- sapply(big.data, mean, na.rm=TRUE)
big.data.sd <- sapply(big.data, sd, na.rm=TRUE)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
DT <- data.table(big.data)
tidy <- DT[, lapply(.SD, mean), by="Activity,Subject"]
write.table(tidy, file="tidy.csv", sep=",", row.names = FALSE)