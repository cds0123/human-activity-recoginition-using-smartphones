library(dplyr)

source("loader.R")

set_data_dir("data")

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 4. Appropriately labels the data set with descriptive variable names. 
train <- build_dataframe(T)
test <- build_dataframe(F)
train$is_train <- T
test$is_train <- F
df <- rbind(train, test)

# 3. Uses descriptive activity names to name the activities in the data set
activity_names <- read.table(file.path(data_dir, "activity_labels.txt"), header=F, sep="")
activity_names <- as.vector(activity_names[,2])
df[, "activity_type"] <- sapply(df[, "activity_type"], function(x) { activity_names[x] })

# 5. From the data set in step 4, creates a second,
#    independent tidy data set with the average of each variable for each activity and each subject.
source("helper.R")

df_grouped <- build_grouped_df(df)