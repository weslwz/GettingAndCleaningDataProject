The datasets are stored in a directory called "tidy"

The process to generate the datasets are as follows.
1. merge the train and test data into one data frame containing variables corresponding to activity label, subject id and then the 561 features
2. Label the variable names and activities with more descriptive names
3. Extract only variables containing the the string mean() or std() (plus the subject and activity labels)
4. Creates a second tidy data set with the average of each variable for each activity and each subject. 
5. Save the dataset in step 3 as X.csv and in step 4 as Y.csv.

See run_analysis.R for more details