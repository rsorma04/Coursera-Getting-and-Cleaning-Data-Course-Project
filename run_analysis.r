library(reshape2)

# Set file name.
week_4_file <- "project_dataset.zip"

# Get the data from the web location and insert it into the appropriate location.
if (!file.exists(week_4_file)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, week_4_file, method = "curl")
}

# Unzip data set.
unzip(week_4_file)

########### Prepare Features #############  
# Get the 2nd column of the featues dataset.
features <- read.table("UCI HAR Dataset/features.txt")[,2]
# Turn the featues vector into a character from factor b/c they will be used as column
# labels.
features <- as.character(features)
# Remove symbols and numbers.
features <- gsub('[-(),]', '', features)  

########## Prepare Activity Lables ########

# Get the 2nd column of the activities dataset.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# Turn the activities second column into a character from factor b/c they will be 
# used as an activity label.
activities[, 2] <- as.character(activities[,2])

######## Prepare Test Data #######

#  Leoad Main Test Data  
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")   

#  Load Subjects Test Data
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")  

#  Load Activities Test Main Data Set
activity_test_main <- read.table("UCI HAR Dataset/test/y_test.txt")

# Combine All Test Data
test_set <- cbind(subjects_test, activity_test_main, test_data)
######## Prepare Training Data #######  


#######Prepare Training Data ############

# Load Main Training Data  
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")

#  Load Subjects Training  Data
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#  Load Activities Training Main Data Set
activity_train_main <- read.table("UCI HAR Dataset/train/y_train.txt")

training_set <- cbind(subjects_train, activity_train_main, train_data)

################ Bind Both Datasets to Make One Data Set #############
######  Combine Test and Training Data
untidy_overall_dataset <- rbind(test_set, training_set)
## Set column names.
colnames(untidy_overall_dataset) <- c("subject", "activity", features)
## Merge in activity names.
untidy_overall_dataset$activity <- factor(untidy_overall_dataset$activity, levels = activities[,1],
                                          labels = activities[,2])
#  Set the string combination names for the columns we're interested in keeping 
#  for our data set.
col_needed <- c("subject", "Subject", "activity", "Activity", "std", "Std", "mean", "Mean")
#  Extract a dataset that only contains column string names that we're interested
#  in keeping.
untidy_overall_dataset <- untidy_overall_dataset[, grep(paste(col_needed, collapse = "|"), colnames(untidy_overall_dataset))]

################ Create New Data Set With the Average of Each Variable for Each Activity and Subject ############

# Turn activities and subjects into factors.
final_data_melted <- melt(untidy_overall_dataset, id = c("subject", "activity"))
final_data_avg <- dcast(final_data_melted, subject + activity ~ variable, mean)

############## Write Average Data to File ####################
write.table(final_data_avg, "tidy.txt", row.names = FALSE, quote = FALSE)
