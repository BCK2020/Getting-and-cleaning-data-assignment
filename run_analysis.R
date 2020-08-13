# 1.Merge training and test sets to create one data set
X<- rbind(x_test,x_train)
Y<- rbind(y_test,y_train)
Subject<- rbind(subject_test, subject_train)
Merged_Data <- cbind(Subject, X, Y)

# 2.Extract measurements on mean and standard deviation for each measurement
mean_std <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))

# 3.Descriptive activity name for activities in data set
activity_name<-merge(mean_std, activities, by = "code")

# 4.label data set with descriptive variable names
gsub("mean", "Mean", names(activity_name))
gsub("std", "Standard_Deviation", names(activity_name))

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Subject_activity <- group_by(activity_name, subject, activity)
tidy_data_set<-summarize_all(Subject_activity, funs(mean))
write.table(tidy_data_set, "TidyDataSet.txt", row.name=FALSE)
codebook(tidy_data_set)