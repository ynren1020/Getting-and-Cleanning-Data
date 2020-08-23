

# download data ---

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "project.zip", method = "curl")

# read data ---
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n","stats"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$stats)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$stats)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")


# rbind ---
x_df <- rbind(x_test,x_train)
y_df <- rbind(y_test,y_train)
s_df <- rbind(s_test,s_train)
# cbind ---
total <- cbind(s_df, y_df, x_df)


# Extracts only the measurements on the mean and standard deviation for each measurement.
total.sub <- total[, c(1,2,grep("mean", names(total)),grep("std", names(total)))] 

# Uses descriptive activity names to name the activities in the data set
total.sub$activity <- activities[total.sub$code, 2]

# Appropriately labels the data set with descriptive variable names.
names(total.sub)<-gsub("Acc", "Accelerometer", names(total.sub))
names(total.sub)<-gsub("Gyro", "Gyroscope", names(total.sub))
names(total.sub)<-gsub("Mag", "Magnitude", names(total.sub))
names(total.sub)<-gsub("^t", "Time", names(total.sub))
names(total.sub)<-gsub("^f", "Frequency", names(total.sub))
names(total.sub)<-gsub("angle", "Angle", names(total.sub))
names(total.sub)<-gsub("gravity", "Gravity", names(total.sub))

# summarize 
total.sub.sum <- total.sub %>%
    dplyr::group_by(subject, activity) %>%
    dplyr::summarise_all(mean)
write.table(total.sub.sum, "Means4activitypersubject.txt", row.name=FALSE,
            col.names = TRUE, sep = "\t", quote = FALSE)





