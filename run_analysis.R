
library(reshape2)

## Read the corresponding files
## Bind Rows of sames files 
## Remove redundant objects from memory
features_names <- read.table("./UCI HAR Dataset/features.txt")
activities_names <- read.table("./UCI HAR Dataset/activity_labels.txt") 

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_total <- rbind(X_test, X_train)
rm(X_test,X_train)

Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
Y_total<- rbind(Y_test, Y_train)
rm(Y_test,Y_train)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_total<- rbind(subject_test, subject_train)
rm(subject_test,subject_train)



## Select "mean" and "std" columns
col_mean <- grep("*mean()*", features_names[,2])
col_std  <- grep("*std()*", features_names[,2])
column_filter <- sort(c(col_mean, col_std))

names(X_total) = features_names[,2]
X_total <- X_total[, column_filter]

## Give Activities descriptive names. 
Y_total <- as.factor(Y_total[,1])
levels(Y_total) = activities_names[,2]

subject_total <- as.factor(subject_total[,1])

## Merge the data frames
## Create the tidy Data Set

LargeDataSet <- cbind(Y_total, subject_total, X_total)
names(LargeDataSet) = c("activity", "subject", names(X_total))

meltDS = melt(LargeDataSet, id=c("activity", "subject"), measure.vars = names(X_total))
rm(LargeDataSet)
TidyDataSet = dcast(meltDS, activity + subject ~ variable, mean)
rm(meltDS)

# Write Output in Long (narrow) format
TidyDataSet <- melt(TidyDataSet, id=c("activity", "subject"), measure.vars = names(X_total))
write.table(TidyDataSet, file = "tidydataset_narrow.txt", row.name = FALSE)
