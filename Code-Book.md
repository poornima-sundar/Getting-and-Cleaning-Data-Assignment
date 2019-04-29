The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.
1.	Download the dataset
	- Dataset downloaded and extracted under the folder called UCI HAR Dataset

2.	Assign each data to variables

3.	Merges the training and the test sets to create one data set
	- Merged_Data (10299 rows, 563 column) is created.

4.	Extracts only the measurements on the mean and standard deviation for each measurement
	- Data.Sub (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5.	Uses descriptive activity names to name the activities in the data set
	- Entire numbers in code column of the Data.Sub is replaced with corresponding activity taken from second column of the activities variable

6.	Appropriately labels the data set with descriptive variable names
	- code column in Data.sub renamed into activities
	- Expand Abbreviations
	- Remove Special Characters

7.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	- FinalData (180 rows, 88 columns) is created by sumarizing Data.sub taking the means of each variable for each activity and each subject, after grouping by subject and activity.
	- Export FinalData into FinalData.txt file.

