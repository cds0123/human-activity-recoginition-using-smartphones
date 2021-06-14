#` Helper functions to load data set

data_dir = "UCI HAR Dataset"

filenames <- c(
  "body_acc_x_%s.txt", "body_acc_y_%s.txt", "body_acc_z_%s.txt",
  "body_gyro_x_%s.txt", "body_gyro_y_%s.txt", "body_gyro_z_%s.txt",
  "total_acc_x_%s.txt", "total_acc_y_%s.txt", "total_acc_z_%s.txt"
)

#' Set directory path containing data files
#' The original data is from:
#'   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#' 
#' It is assumed that data directory structure is:
#'   .
#'   |- activity_labels.txt
#'   |- feature_info.txt
#'   |- features.txt
#'   |- test/
#'   |- train/
#'   
#' so if there are any missing files or directories, it will not work properly.
#' Original directory name is "UCI HAR Dataset" so if you changed the name,
#' you have to call this function first.
#' 
#' @param dir_path character Path to data directory
set_data_dir <- function(dir_path) {
  data_dir <<- dir_path 
}

#' Create file path to read.
#' Assumed the directory containing data set is "./data/(train|test)/Inertial Signals/"
#' 
#' @param filename character Base file name to read
#' @param is_train logical   If set this to TRUE, read from train directory,
#'                           otherwise, test directory
#' @return File path
build_path <- function(filename, is_train = T) {
  type <- ifelse(is_train, "train", "test")
  file.path(data_dir, type, "Inertial Signals", sprintf(filename, type))
}

#' Create column names
#' 
#' @param filepaths character Base file names to name column names.
#' @return Vector of names used for columns.
#'         This will be ["{name1}_mean", "{name1}_sd", "{name2}_mean", ...]
build_colnames <- function(filepaths) {
  names <- sub("_%s.txt", "", filepaths)
  names <- sapply(names, function(x) {
    c(paste(x, "_mean", sep=""), paste(x, "_sd", sep=""),
      paste("abs_", x, "_mean", sep=""), paste("abs_", x, "_sd", sep=""))
  })
  as.vector(names)
}

#' Build train/test data frame by merging data set.
#'
#' @param is_train logical Whether load from training or testing data set
#' @param nrows numeric    number of rows to load, set to -1 and load all data (default=-1)
#' @return data.frame of either train or test data set
build_dataframe <- function(is_train = T, nrows = -1) {
  type = ifelse(is_train, "train", "test");
  
  # load base data set
  x_df <- read.table(
    file.path(data_dir, sprintf("%s", type), sprintf("X_%s.txt", type)),
    header=F,
    sep="",
    nrows=nrows
  )
  y_df <- read.table(
    file.path(data_dir, sprintf("%s", type), sprintf("y_%s.txt", type)),
    header=F,
    sep="",
    nrows=nrows
  )
  subject <- read.table(
    file.path(data_dir, sprintf("%s", type), sprintf("subject_%s.txt", type)),
    header=F,
    sep="",
    nrows=nrows
  )
  
  df <- cbind(subject,
              y_df,
              apply(x_df, 1, mean),
              apply(x_df, 1, sd))
  
  # merge sub data set that is extracted by different sensors in different coordination
  # (e.g. accelerator in x-axis, y-axis, or gyro sensor, etc.)
  for (filename in filenames) {
    data <- read.table(build_path(filename, is_train), header=F, sep="", nrows=nrows)
    # only mean and standard deviation are appended to data.frame by requirements
    df <- cbind(df, apply(data, 1, mean), apply(data, 1, sd), apply(abs(data), 1, mean), apply(abs(data), 1, sd))
  }
  names(df) <- c("subject_id", "activity_type", "x_mean", "x_sd", build_colnames(filenames))
  df 
}