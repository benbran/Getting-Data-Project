
# merge and create one dataset
train_dat <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
train_lab <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
train_subj <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
test_dat <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
test_lab <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt") 
test_subj <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
join_dat <- rbind(train_dat, test_dat)
join_lab <- rbind(train_lab, test_lab)
join_subj <- rbind(train_subj, test_subj)



# only get measurements of mean & stddev for measurements
features <- read.table("./UCI\ HAR\ Dataset/features.txt")
mean_stdind <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_dat <- join_dat[, mean_stdind]
names(join_dat) <- gsub("\\(\\)", "", features[mean_stdind, 2]) # remove "()"
names(join_dat) <- gsub("mean", "Mean", names(join_dat)) # capitalize M
names(join_dat) <- gsub("std", "Std", names(join_dat)) # capitalize S
names(join_dat) <- gsub("-", "", names(join_dat)) # remove "-" in column names 



# descriptive activity names to rename activities
activity <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[join_lab[, 1], 2]
join_lab[, 1] <- activityLabel
names(join_lab) <- "activity"



# label properly
names(join_subj) <- "subject"
clean_dat <- cbind(join_subj, join_lab, join_dat)
write.table(clean_dat, "merge.txt") # write out the 1st dataset



# make tidy dataset w/ avg of each var for each activity and each subj
subjectLen <- length(table(join_subj)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(clean_dat)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(clean_dat)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(join_subj)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == clean_dat$subject
        bool2 <- activity[j, 2] == clean_dat$activity
        result[row, 3:columnLen] <- colMeans(clean_dat[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
write.table(result, "w_means.txt") # write out the 2nd dataset

