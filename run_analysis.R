#######################################################
# file:          run_analysis.R
# content:       Contains the solution to the getting and cleaning course project
#             
# author:        Jurn Franken
# dataset used:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# dataset is downloaded and unzipped in a directory called: "UCI HAR Dataset" 

# first the necessary datafiles are read.
#    the X datasets contain the measurements of the sensor
#    the y datasets contain the activity labels

library("dplyr")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features        <- read.table("UCI HAR Dataset/features.txt")

subject_test    <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test          <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test          <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train    <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train          <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train          <- read.table("UCI HAR Dataset/train/y_train.txt")

# create some helper variables
activity_labels_vector <- activity_labels[,2]                                     # create vector with activity labels
features_vector        <- features[,2]                                            # create vector with features
# mean_std_features      <- features_vector[grep('mean()|std()', features_vector)]  # vector with only mean() and std() column names

# merge test and train data
X_all            <- rbind(X_test, X_train)
colnames(X_all)        <- features_vector                   # name the X_all data columns

y_all            <- rbind(y_test, y_train)                  
colnames(y_all) <- "activity"                               # name the y_all data vector

subject_all      <- rbind(subject_test, subject_train)
colnames(subject_all) <- "subject"                          #name the subject_all data vector

# create a structured dataset:
# X_Struct:
X_struct <- cbind(subject_all,y_all,X_all[,grep('mean\\(\\)|std\\(\\)', features_vector)])  # create dataset with subjects, activities and mean & std columns
X_struct$subject <- as.factor(X_struct$subject)

X_struct$activity <- factor(X_struct$activity, labels=activity_labels_vector)       # use descriptive activity names

X_means <- aggregate(X_struct, by=list(X_struct$subject,X_struct$activity), FUN=mean)

X_means$subject <- NULL
X_means$activity <- NULL
colnames(X_means)[1] <- "subject"
colnames(X_means)[2] <- "activity"

X_means <- X_means[order(X_means$activity,X_means$subject),]

#And writeout the data to a txtfile.
write.table(x = X_means, file = "tidy_dataset.txt", row.name=FALSE)