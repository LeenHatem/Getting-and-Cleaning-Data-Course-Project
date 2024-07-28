# Load necessary libraries
library(dplyr)

#####1
# Set the working directory to the location where the UCI HAR Dataset was unzipped
setwd("D:\\coursera data courses\\data cleaning using R\\week 4\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", col.names = c("activityId", "activityType"))

#####4
clean_feature_names <- gsub("[()]", "", features$V2)
clean_feature_names <- gsub("-", ".", clean_feature_names)
clean_feature_names <- gsub("^t", "time.", clean_feature_names)
clean_feature_names <- gsub("^f", "frequency.", clean_feature_names)
clean_feature_names <- gsub("BodyBody", "Body", clean_feature_names)

subject_train <- read.table("train/subject_train.txt", col.names = "subjectId")
x_train <- read.table("train/X_train.txt", col.names = clean_feature_names)
y_train <- read.table("train/y_train.txt", col.names = "activityId")

subject_test <- read.table("test/subject_test.txt", col.names = "subjectId")
x_test <- read.table("test/X_test.txt", col.names = clean_feature_names)
y_test <- read.table("test/y_test.txt", col.names = "activityId")

subject_data <- rbind(subject_train, subject_test)
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

# Combine all data into one data set
merged_data <- cbind(subject_data, y_data, x_data)

######2
# many columns are for the mean or std, extracting the columns that have these in their name
mean_std_columns <- grep("mean|std", clean_feature_names, value = TRUE)
selected_columns <- c("subjectId", "activityId", mean_std_columns)
extracted_data <- merged_data[c(selected_columns)]

######3
extracted_data <- merge(extracted_data, activity_labels, by = "activityId")


#######5
tidy_data <- extracted_data %>%
  group_by(subjectId, activityType) %>%
  summarise(across(everything(), mean))
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
