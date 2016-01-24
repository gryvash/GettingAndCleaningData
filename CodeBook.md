# CodeBook

# Input data

Data is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Output data

As a results the tidy data set is generated and saved to "tidy_data.txt"  
This file contains 68 variables:  
Subject - subject id - int  
Activity - activity label - string  
tBodyAccmean?, tBodyAccstd?, tGravityAccmean?, tGravityAccstd?, tBodyAccJerkmean?, tBodyAccJerkstd?, tBodyGyromean?, tBodyGyrostd?, tBodyGyroJerkmean?, tBodyGyroJerkstd?, tBodyAccMagmean, tBodyAccMagstd, tGravityAccMagmean, tGravityAccMagstd, tBodyAccJerkMagmean, tBodyAccJerkMagstd, tBodyGyroMagmean, tBodyGyroMagstd, tBodyGyroJerkMagmean, tBodyGyroJerkMagstd, fBodyAccmean?, fBodyAccstd?, fBodyAccJerkmean?, fBodyAccJerkstd?, fBodyGyromean?, fBodyGyrostd?, fBodyAccMagmean, fBodyAccMagstd,	fBodyBodyAccJerkMagmean, fBodyBodyAccJerkMagstd, fBodyBodyGyroMagmean, fBodyBodyGyroMagstd, fBodyBodyGyroJerkMagmean, fBodyBodyGyroJerkMagstd - normalized unitsless mean and std values - decimal.  
? corresponds to X and Y and Z.  
All values are  the average of each variable for each activity and each subject from original data set. For details see description of original data set in "UCI HAR Dataset\features_info.txt"

# Transformations 
Set the appropriate column names for original data sets  
Merge training and test sets  
Add subjects id and activity names to the obtained set  
Substitute only columns which contain mean() or std() in their names  
## NOTE: as discussed at Coursera forums, columns having meanFreq and others of such type are excluded
Set the activity names based on their id  
Melt data by activity and subject  
Cast data on activity + subject using mean  
Write tidy data set  