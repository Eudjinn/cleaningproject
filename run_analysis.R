runAnalysis <- function() {
    print("Started the analysis, please wait...")

    # Read the measurements
    test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
    train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
    
    features <- read.delim("./UCI HAR Dataset/features.txt", 
                           sep = " ", 
                           header = FALSE, 
                           col.names = c("fatureId", "featureName"))
    
    activities <- read.delim("./UCI HAR Dataset/activity_labels.txt",
                             sep = " ", 
                             header = FALSE, 
                             col.names = c("activityId", "activityName"))
    
    measures.x <- bind_rows(train.x, test.x)
    # unique column names are needed in order for the select from dplyr library to work
    names(measures.x) <- make.names(features$featureName, unique = TRUE)
    
    # Read activities
    test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")
    train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")
    measures.y <- bind_rows(train.y, test.y)
    names(measures.y) <- "activityId"
    
    # subject ids
    test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    measures.subject <- bind_rows(test.subject, train.subject)
    names(measures.subject) <- "subjectId"
    
    # put all measurements into one data frame
    complete.x <- bind_cols(measures.subject, measures.y, measures.x)
    
    # take only mean and std measurements
    selected.x <- select(complete.x, subjectId, activityId, matches("\\.(mean|std)\\."))
    
    # replace activityId with activityName using join.
    joined.x <- selected.x %>% 
        left_join(activities, by = "activityId") %>%
        select(-activityId)
    
    # column "activityName" is the last in the column list after join, 
    # it is better to rearrange the order of columns
    x <- bind_cols(select(joined.x, subjectId), 
                   select(joined.x, activityName), 
                   select(joined.x, -subjectId, -activityName))
    
    # Make better names for the features
    # Remove all dots
    names(x) <- gsub("\\.", "", names(x))
    # mean to Mean and std to Std
    names(x) <- gsub("mean", "Mean", names(x))
    names(x) <- gsub("std", "Std", names(x))
    
    # calculate average of all the variables grouped by subjectId and activityName
    avg.grouped.x <- ddply(x, .(subjectId, activityName), numcolwise(mean))
    
    # Modify names to reflect the average operation that has just been applied, 
    # we skip subjectId and activityName
    names.length <- length(avg.grouped.x)
    names(avg.grouped.x)[3:names.length] <- paste0(names(avg.grouped.x)[3:names.length], "Avg")
    
    # save result
    write.table(avg.grouped.x, "tidy_dataset.txt", row.names = FALSE)
    
    print("Done!")
}