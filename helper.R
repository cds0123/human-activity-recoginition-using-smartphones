#' Build data frame with grouping by subject and activity.
#' Note that this does not include standard deviation.
#' 
#' @param df data.frame Input data frame created with `build_dataframe()`
#' @return tbl_df with mean values of each subject and activity.
build_grouped_df <- function(df) {
  # take all label names except standard deviation related
  # (only average is required by definition)
  label_names <- names(df)
  label_names <- label_names[!grepl("_sd$", label_names)]
  
  df2 <- df[, label_names]
  df2 <- as_tibble(df2)
  df2 %<>% group_by(subject_id, activity_type, is_train) %>%
    summarize(x_mean=mean(x_mean),
              body_acc_x_mean=mean(body_acc_x_mean),
              abs_body_acc_x_mean=mean(abs_body_acc_x_mean),
              body_acc_y_mean=mean(body_acc_y_mean),
              abs_body_acc_y_mean=mean(abs_body_acc_y_mean),
              body_acc_z_mean=mean(body_acc_z_mean),
              abs_body_acc_z_mean=mean(abs_body_acc_z_mean),
              body_gyro_x_mean=mean(body_gyro_x_mean),
              abs_body_gyro_x_mean=mean(abs_body_gyro_x_mean),
              body_gyro_y_mean=mean(body_gyro_y_mean),
              abs_body_gyro_y_mean=mean(abs_body_gyro_y_mean),
              body_gyro_z_mean=mean(body_gyro_z_mean),
              abs_body_gyro_z_mean=mean(abs_body_gyro_z_mean),
              total_acc_x_mean=mean(body_acc_x_mean),
              abs_total_acc_x_mean=mean(abs_body_acc_x_mean),
              total_acc_y_mean=mean(body_acc_y_mean),
              abs_total_acc_y_mean=mean(abs_body_acc_y_mean),
              total_acc_z_mean=mean(body_acc_z_mean),
              abs_total_acc_z_mean=mean(abs_body_acc_z_mean))
  
  df2
}