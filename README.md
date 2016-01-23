# GettingAndCleaningData

## Getting and cleaning data week 4 assignment

This repo contains a single script called "run_analysis.R" to perform the required analysis.
Script has three functions: \
getRawData <- function()\
prepareData <- function(mFileList)\
run_analysis<-function()\
First two functions are used by "run_analysis" function

# getRawData function
Check wether required data is already exist in the local storage, download and extract the data from a .zip file if necessary

# prepareData function
Read all the required data (test and training sets), including variable names, subject id and activity names.
Set the appropriate column names, merges the training and test sets, adds subjects id and activity names to the obtained set.
Substitutes only columns which contain mean() or std() in their names.

NOTE: as discussed at Coursera forums, columns having meanFreq and others of such type are excluded.

Finally it sets the activity names based on their id.

# run_analysis
Does all the job :)\
At first it calls "getRawData", then "prepareData". Then data is melted by activity and subject and casted on their sum using mean.
Obtained table is a required by assignment tidy data set.