# Cleaning-Data-Course-Project
This Script corresponds to the Course Project for the "Getting and Cleansing Data" Course, as part of the Data Science Specialization in Coursera.


### Files included

run_analysis.R  - R Scripting. See details below.
tidydataset_narrow.txt - Output file Example (in narrow: variable / value format)
Code Book.md - Variables description
README.md - This file

Data to be analyzed must be downloaded and unzip to your working directory
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description of the data is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### R Script explained
Comments are included in the code.

Steps:
- Load required packages (reshape2: used to convert and process data frames in a variable/value molten format)
- Reads the data files: 
	features.txt (variable names) 
	activities_labels (activity names) 
	X_test and X_train (measures variables)
	Y_test and Y_train (activity: 1 WALKING
 2 WALKING_UPSTAIRS
 3 WALKING_DOWNSTAIRS
 4 SITTING
 5 STANDING 
6 LAYING
) 
	subject.txt (observed subject: 1:30) 

- Test and train files are merged into "total" variables (binding rows).
- As a good practice, objects no longer needed are removed from memory all along the code.	
- From all the variables available only the ones including "mean()" or "std()" in the name are selected. None should have both.
- Subjects and Activities are transformed to Factors to manipulate them easily (to change codes by descriptions using the levels property)
- Columns are merged into a LargeDataSet.  
- Then melt into another dataset (meltDS) in the long form: activity, subject, variable, value.
- The melt dataset in casted to obtain the mean for each activity + subject combination
(for details about dcast see help: http://127.0.0.1:14245/library/reshape2/html/cast.html)
- This DataSet is then melt again to be saved in a long compact format. 
Long Narrow format is accepted as tidy data, see Discussion Forums: https://class.coursera.org/getdata-013/forum/thread?thread_id=31

## How to read the results
In order to read the output file use the following script:
file<- read.table("tidydataset_narrow.txt")

To transform it to a wide dataframe use the following:
names(file) <- c("activity", "subject", "variable", "value")
library(reshape2)
file<- dcast(file, activity + subject ~ variable)   
