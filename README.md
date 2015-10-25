# GCD-Project
Getting and Cleaning Data Course Project

# Overview
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Code
* Reads in test and train datasets, each for X, Y and subject
* Merges the test and train datasets by binding the rows, as they each have correlating rows in order
* Uses grep to extract only mean and standard deviation columns from X
* Uses activities file to rename Y columns
* Updates abberviated names to full names
* Merges the X, Y and subject data by columns
* Tidies the data by aggregating by mean
* Outputs the file

# Naming convention
* time
* frequency
* Accelerometer
* Gyroscope
* Magnitude
* Body

