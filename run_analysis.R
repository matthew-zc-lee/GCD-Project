library(plyr)

#########################################################################
## 1. Merges the training and the test sets to create one data set.

##	Read datasets
	x_train 	<- read.table("train/X_train.txt")
	y_train 	<- read.table("train/y_train.txt")
	subject_train 	<- read.table("train/subject_train.txt")
	x_test 		<- read.table("test/X_test.txt")
	y_test 		<- read.table("test/y_test.txt")
	subject_test 	<- read.table("test/subject_test.txt")

##	Merge
	MergeX 		<- rbind(x_train, x_test)
	MergeY 		<- rbind(y_train, y_test)
	MergeSubject 	<- rbind(subject_train, subject_test)

#########################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

##	Read features
	features <- read.table("features.txt")

## 	Extract only mean or std columns
	featuresMeanStdev <- grep("mean|std", features[, 2])
	MergeXMeanStd <- MergeX[, featuresMeanStdev]
	names(MergeXMeanStd) <- features[featuresMeanStdev, 2]

#########################################################################
## 3. Uses descriptive activity names to name the activities in the data set

##	Read activities
	activities <- read.table("activity_labels.txt")

## 	update values with correct activity names
	MergeY[, 1] <- activities[MergeY[, 1], 2]
	names(MergeY) <- "activity"

#########################################################################
## 4. Appropriately labels the data set with descriptive variable names. 
	names(MergeXMeanStd) <- gsub("^t", "time", names(MergeXMeanStd))
	names(MergeXMeanStd) <- gsub("^f", "frequency", names(MergeXMeanStd))
	names(MergeXMeanStd) <- gsub("Acc", "Accelerometer", names(MergeXMeanStd))
	names(MergeXMeanStd) <- gsub("Gyro", "Gyroscope", names(MergeXMeanStd))
	names(MergeXMeanStd) <- gsub("Mag", "Magnitude", names(MergeXMeanStd))
	names(MergeXMeanStd) <- gsub("BodyBody", "Body", names(MergeXMeanStd))
	names(MergeSubject) <- "subject"

#########################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##	bind all the data in a single data set
	MergeALL <- cbind(MergeXMeanStd, MergeY, MergeSubject)
	Tidy<-aggregate(. ~subject + activity, MergeALL, mean)
	Tidy<-Tidy[order(Tidy$subject,Tidy$activity),]

	write.table(Tidy, "averages_data.txt", row.name=FALSE)