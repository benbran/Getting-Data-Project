Getting and Cleaning Data Project CodeBook
=================================================
  
* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./UC HAR Dataset/train" folder and store them in *train_dat*, *train_lab* and *train_subj*.      
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in *testData*, *test_lab* and *test_subj*.  
 3. Concatenate *test_dat* to *train_dat* to generate a new data frame, *join_dat*; concatenate *test_lab* to *train_lab* to generate new data frame, *join_lab*; concatenate *testSubject* to *train_subj* to generate a new data frame, *join_subj*.  
 4. Read features.txt from the "/UCI HAR Dataset" folder and store the data in *features*. We only extract the measurements on the mean and standard deviation. This is a 66 index list. We get a subset of *join_dat* with the 66 corresponding columns.  
 5. Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.   
 6. Read activity_labels.txt "./UCI HAR Dataset" and store the data in *activity*.
 7. Clean the activity names of second column of *activity*. 
 8. Transform the values of *join_lab* according to the *activity* data frame.  
 9. Combine *join_subj*, *join_lab* and *join_dat* by column to get a new data frame, *cleaned_dat*. Name the first two columns, "subject" and "activity". "subject" contains integers that range from 1 to 30; "activity" contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.  
 10. Write *cleaned_dat* to "merge.txt"   
 11. Generate a new independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which gives 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. 
 12. Write the *result* out to "w_means.txt" file in current working directory. 
 
