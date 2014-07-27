## Read in the training data into a data frame
## Variables are ordered as: activity label, subject id, then the 561 features
X <- cbind(
   read.table(file.path("UCI HAR Dataset", "train", "y_train.txt")),
   read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt")),
   read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"))
)

## Similarily, read in the training data into a data frame
## Then assemble trainning and testing data as one data frame
X <- rbind(X, cbind(
   read.table(file.path("UCI HAR Dataset", "test", "y_test.txt")),
   read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt")),
   read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"))
))


## Appropriately label the variables
featNames <- read.table(file.path("UCI HAR Dataset", "features.txt"), colClasses=c("NULL", "character"))
varNames <- c("activity-label", "subject-id", featNames[[1]])
colnames(X) <- varNames

## Give activity_label descriptive names by converting to named factors
labels <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"), colClasses=c("numeric", "character"))
X[["activity-label"]] <- factor(X[["activity-label"]], levels=labels[[1]], labels=labels[[2]])


## Extracts only the measurements on the mean and standard deviation for each measurement
ind <- grep("mean\\(\\)|std\\(\\)", colnames(X))
X <- X[,c(1,2,ind)]

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
Y <- aggregate(X[,-c(1,2)], by=X[c(1,2)], mean)
Y <- Y[order(Y[[1]],Y[[2]]),]; rownames(Y) <- NULL

## write current data frames to a folder called tidy
write.csv(X, file=file.path("tidy", "X.csv"))
write.csv(Y, file=file.path("tidy", "Y.csv"))
