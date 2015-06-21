setwd("/Users/Vincent/Dropbox/Excel Course Development/Getting And Cleaning Data/Project 2")

# Read Training Data
train_data = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

# Adding Training Label as new column
train_data[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)

# Adding Subject Details as new column
train_data[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

###########

# Read Testing Data

test_data = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test_data[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_data [,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

###########

# Read activityLabels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Read features label and clean up
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merge Data
Data = rbind(train_data, test_data)

# Extract only measurements on the mean and standard deviation
DataMeanStd <- grep(".*Mean.*|.*Std.*", features[,2]) #First Extract the row index number of data we want
features <- features[DataMeanStd,]

# Add back 2 new rows of 562 563
DataMeanStd <- c(DataMeanStd, 562, 563)

# Remove unwanted column from dataset
Data <- Data[,DataMeanStd]

# Add column names from feature to Data, then lowercase them
colnames(Data) <- c(features$V2, "Activity", "Subject")
colnames(Data) <- tolower(colnames(Data))

# for-loop to go in activityLabels$V2
# replace each element in Data$activity from number to type of activity
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  Data$activity <- gsub(currentActivity, currentActivityLabel, Data$activity)
  currentActivity <- currentActivity + 1
}

# Convert to factors
Data$activity <- as.factor(Data$activity)
Data$subject <- as.factor(Data$subject)

# Splits data into subsets, computes summary statistics for each
# aggregate (x, by, FUN, ...)
# Sort by subject first then activity
Stat_Data = aggregate(Data, by=list(activity = Data$activity, subject=Data$subject), mean)

# Sort by activity first then subject
# Stat_Data2 = aggregate(Data, by=list(subject=Data$subject, activity = Data$activity), mean)

# Remove column 90 and 89 as no meaningful result for statistic calculation
Stat_Data[,90] = NULL
Stat_Data[,89] = NULL
write.table(Stat_Data, "tidydata.txt", row.names= FALSE)