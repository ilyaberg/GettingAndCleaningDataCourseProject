
library(dplyr)
#Step 1 Reading column names from feature.txt, same list for 
#train and test data sets

features <- read.table(file = "./data/features.txt", stringsAsFactors = FALSE)
#View(features)


#Converting column names to valid names

features <- make.names(features[,2])


#Reading activity names, same list of train and data sets
activity <- read.table(file = "./data/activity_labels.txt", stringsAsFactors = FALSE)
names(activity) <- c("id", "activity")

#dim(activity)
#head(activity)


#Reading train data set
raw_train_data <- read.table(file = "./data/train/X_train.txt", 
                      colClasses = "numeric",
                      stringsAsFactors = FALSE)


x_train <- tbl_df(raw_train_data)


#Assigning descriptive variable names to columns of train data set
names(x_train) <- features
#View(x_train)


#Reading subjects for train data set
subject_train <- read.table(file = "./data/train/subject_train.txt", stringsAsFactors = FALSE)

#Giving a name "subject"
names(subject_train) <- c("subject")

#Reading activities for train data set
y_train <- read.table(file = "./data/train/y_train.txt", stringsAsFactors = FALSE)

#Giving a name to activity data for train data set
names(y_train) <- c("activity_id")

#Binding train data set, subjects and activity ids
x_train <- cbind(x_train, subject_train, y_train)
#dim(x_train)


#Merging resulting data set with activity names
merged_x_train <- merge(x_train, activity, by.x ="activity_id", 
                        by.y = "id", all = TRUE)

#Taking only those columns that have unique names.  
merged_x_train1 <- merged_x_train[unique(names(merged_x_train))]
#Thus for training data set we have a data frame with 7352 raws and 480 columns

#Below steps will repeat the same procedure as above but for test data set

#Reading test data set
raw_test_data <- read.table(file = "./data/test/X_test.txt", 
                            colClasses = "numeric",
                            stringsAsFactors = FALSE)

x_test <- tbl_df(raw_test_data)

#Assigning descriptive variable names to columns of test data set
names(x_test) <- features

#Reading subjects for test data set
subject_test <- read.table(file = "./data/test/subject_test.txt", stringsAsFactors = FALSE)

names(subject_test) <- c("subject")

#Reading activities for test data set
y_test <- read.table(file = "./data/test/y_test.txt", stringsAsFactors = FALSE)

names(y_test) <- c("activity_id")

#Binding test data set, subjects and activity ids.
x_test <- cbind(x_test, subject_test, y_test)

#Merging resulting data set with activity names
merged_x_test <- merge(x_test, activity, by.x ="activity_id", 
                        by.y = "id", all = TRUE)
#dim(merged_x_test)

#View(merged_x_test)
#head(merged_x_test, 10)[, c(1, 2, 562, 563, 564)]
#tail(merged_x_test)[, c(1, 2, 562, 563, 564)]

#Taking only those columns that have unique names.  
merged_x_test1 <- merged_x_test[unique(names(merged_x_test))]
#Thus for training data set we have a data frame with 7352 raws and 480 columns



#l <- names(merged_x_train1) == names(merged_x_test1) #to check that the names 
                                                        #are the same

#Binding together trai data set and test data set
merged_df <- rbind(merged_x_train1, merged_x_test1)


#Selecting columns that contain mean, std as we need only mean and std
#in addition selecting columns activity and subject as they should not be lost

library(stringr)

pattern <- "mean|std|activity|subject"

columnsToKeep <- grepl(pattern, names(merged_df), ignore.case = TRUE)

merged_df <- merged_df[,columnsToKeep]
#dim(merged_df)
#names(merged_df)

#Taking away column "activity_id" as it is reduntant as we already have  
#activity names

merged_df1 <- select(merged_df, -activity_id)

#Creating a tide data set with the average of each variable 
#for each activity and each subject

fdf <- aggregate(merged_df1, by = list(merged_df1$activity, merged_df1$subject), 
                 FUN = "mean")

#Sorting by subject and activity

fdf <- arrange(fdf, Group.2, Group.1)


#Taking away columns "subject" and "activity" as they were replaced by
#Group.2 and Group.1 by arrange function

fdf <- select(fdf, -c(subject,activity))


#Changing colNames Group.2 and Group.1 to subject and activity
names(fdf)[1:2] <- c("activity", "subject")

#write.table(fdf, file = "tidy_data_set.txt", row.names = FALSE)

