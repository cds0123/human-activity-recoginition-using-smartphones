# Data Processing

In this document, it will explore the data set how to process and describe about the values of each column.

## Environment
The scripts are tested on Ubuntu 20.04.
Note that the scripts are written for any environment, but it is not tested in the other environment, so it does not gurantee if it works.

The scripts are written with `R==3.6.2`. `dplyr==1.0.6` is used for some processing.

## Explore Dataset
The original data set is loaded from Human Activity Recognition Using Smartphone
([UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

## Processing dataset

```r
source("loader.R")

# Call this if directory name is not "UCI HAR Dataset".
# In this code book, use ./data as the directory name as an example
# (if you execute `run_analysis.R`, modify an argument in this function)
set_data_dir("data")

# Load data and store them as data.frame
# if you would like to limit the size of rows, set `nrows`
# e.g. build_dataframe(TRUE, 100)
train <- build_dataframe(is_train = TRUE)
test <- build_dataframe(is_train = TRUE)

# Add new parameter to indicate the data is training or testing data set
train$is_train <- TRUE
test$is_train <- FALSE

# Merge train and test data set
df <- rbind(train, test)

# Run the following lines if you prefer to use descriptive activity name
# instead of activity ID
activity_names <- read.table()
df[, "activity_type"] <- sapply(df[, "activity_type"], function(x) activity_names[x] )

# To summarize each subject and activity, take each mean of the group
source("helper.R")

# Pass the data.frame created above
# Note that this will return as tbl_df instead of built-in data.frame class
df_grouped <- build_grouped_df(df)

# If you need to modify back to data.frame (optional)
df_grouped <- as.data.frame(df_grouped)
```

## Variables in Data Frame
In the first data frame (`df` in the example code above), it consists of:

- `subject_id` : Subject identifier who performed the activity (range: 1 - 30)
- `activity_type` : Activity Type (WALKING, WALKING_UPSTAIRS, etc., described in `./data/activity_labels.txt`)
- `x_mean` : Mean of all dataset
- `x_sd`: Standard deviation of all dataset
- `body_acc_[xyz]_mean`: Mean of the acceleration signal obtained by subtracting the gravity from `total_acc_[xyz]`
- `body_acc_[xyz]_sd`: Standard deviation of the same data described at `body_acc_[xyz]_mean`
- `abs_body_acc_[xyz]_mean`: Mean of absolute values of the data described at `body_acc_[xyz]_mean`.
- `abs_body_acc_[xyz]_sd`: Standard deviation of absolute values of the data described at `body_acc_[xyz]_mean`.
- `body_gyro_[xyz]_mean`: Mean of the angular velocities measured by the gyroscope. (radians/sec.)
- `body_gyro_[xyz]_sd`: Standard deviation of the same data described at `body_gyro_[xyz]_mean`
- `abs_body_gyro_[xyz]_mean`: Mean of absolute values of the data described at `body_gyro_[xyz]_mean`.
- `abs_body_gyro_[xyz]_sd`: Standard deviation of absolute values of the data described at `body_gyro_[xyz]_mean`.
- `total_acc_[xyz]_mean`: Mean of the accelaration signal from smartphone accerometer. (unit is standard gravity)
- `total_acc_[xyz]_sd`: Standard deviation of the same data described at `total_acc_[xyz]_mean`
- `abs_total_acc_[xyz]_mean`: Mean of absolute values of the data described at 'total_acc_[xyz]_mean`
- `abs_total_acc_[xyz]_sd`: Standard deviation of absolute values of the data described at 'total_acc_[xyz]_mean`
- `is_train`: Whether data is training or testing data set.

In the second data frame (`df_grouped` in the example code above), it consists of:
- `subject_id`
- `activity_type`
- `is_train`
- `x_mean`
- `body_acc_[xyz]_mean`
- `abs_body_acc_[xyz]_mean`
- `body_gyro_[xyz]_mean`
- `abs_body_gyro_[xyz]_mean`
- `total_acc_[xyz]_mean`
- `abs_total_acc_[xyz]_mean`

The values in `df_grouped` are grouped by each subject and activity from `df`.