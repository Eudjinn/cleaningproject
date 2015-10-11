run_analysis <- function() {
    print("Started the analysis, please wait...")
    ## Read the measurements
    test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
    train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
    
    features <- read.delim("./UCI HAR Dataset/features.txt", 
                           sep = " ", 
                           header = FALSE, 
                           col.names = c("fature_id", "feature_name"))
    
    activities <- read.delim("./UCI HAR Dataset/activity_labels.txt",
                             sep = " ", 
                             header = FALSE, 
                             col.names = c("activity_id", "activity_name"))
    
    measures_X <- bind_rows(train_X, test_X)
    # unique column names are needed in order for the select from dplyr library to work
    names(measures_X) <- make.names(features$feature_name, unique = TRUE)
    
    ## Read activities
    test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
    train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
    measures_y <- bind_rows(train_y, test_y)
    names(measures_y) <- "activity_id"
    
    ## subject ids
    test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    measures_sub <- bind_rows(test_sub, train_sub)
    names(measures_sub) <- "subject_id"
    
    ## put all measurements into one data frame
    complete_X <- bind_cols(measures_sub, measures_y, measures_X)
    
    ## take only mean and std measurements
    selected_X <- select(complete_X, subject_id, activity_id, matches("\\.(mean|std)\\."))
    
    ## replace activity_id with activity_name using join.
    joined_X <- selected_X %>% 
        left_join(activities, by = "activity_id") %>%
        select(-activity_id)
    
    ## column "activity_name" is the last in the column list after join, 
    ## it is better to rearrange the order of columns
    X <- bind_cols(select(joined_X, subject_id), 
                   select(joined_X, activity_name), 
                   select(joined_X, -subject_id, -activity_name))
    
    ## Make better names for the features
    ## Replace first dot with _
    names(X) <- sub("\\.", "_", names(X))
    ## Deal with ... replacing it by _ 
    names(X) <- sub("\\.\\.\\.", "_", names(X))
    ## Remove .. at the end of some feature names. 
    ## The $ sign is redundant but let it be here indicating end of line. 
    names(X) <- sub("\\.\\.$", "", names(X))
    
    ## calculate average of all the variables grouped by subject_id and activity_name
    avg_grouped_X <- ddply(X, .(subject_id, activity_name), numcolwise(mean))
    
    ## Modify names to reflect the average operation that has just been applied, 
    ## we skip subject_id and activity_name
    nl <- length(avg_grouped_X)
    names(avg_grouped_X)[3:nl] <- paste0("Avg_", names(avg_grouped_X)[3:nl])
    
    ## save result
    write.table(avg_grouped_X, "tidy_dataset.txt", row.names = FALSE)
    
    print("Done!")
}