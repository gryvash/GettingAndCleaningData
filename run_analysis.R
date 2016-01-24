getRawData <- function()
{
        mFileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
        # Download the raw data if not exist yet
        if(!file.exists(mFileName))
        {
                mFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(mFileURL, destfile = mFileName)
        }
        
        # Unpack the data if not exist yet
        if(!file.exists("UCI HAR Dataset"))
        {
                unzip(mFileName, exdir = ".")
        }
}

prepareData <- function(mFileList)
{
        # Get activities map
        activitiesMap <- read.table(mFileList$activitiesName, header = FALSE, col.names = c("activityID","activityName"))
        # Get variables map
        variablesMap <- read.table(mFileList$variablesName, stringsAsFactors = FALSE, header = FALSE, col.names = c("columnID","variableName"))
        # Get "test" set with proper names 
        testData <- read.table(mFileList$testData, stringsAsFactors = FALSE, header = FALSE, col.names = gsub("[\\(),-]", "", variablesMap$variableName))
        testActivities <- read.table(mFileList$testActivities, stringsAsFactors = FALSE, header = FALSE, col.names = "Activity")
        testSubject <- read.table(mFileList$testSubject, stringsAsFactors = FALSE, header = FALSE, col.names = "Subject")
        # Get "train" set with proper names 
        trainData <- read.table(mFileList$trainData, stringsAsFactors = FALSE, header = FALSE, col.names = gsub("[\\(),-]", "", variablesMap$variableName))
        trainActivities <- read.table(mFileList$trainActivities, stringsAsFactors = FALSE, header = FALSE, col.names = "Activity")
        trainSubject <- read.table(mFileList$trainSubject, stringsAsFactors = FALSE, header = FALSE, col.names = "Subject")
        
        # Get only mean and std columns
        #relevantColumns <- grep("mean|std", variablesMap$variableName)
        relevantColumns <- grep("mean[:(:][:):]|std", variablesMap$variableName)
        # Combine data with activities and subject
        readyTrain <- cbind(trainData[relevantColumns], trainActivities, trainSubject)
        readyTest <- cbind(testData[relevantColumns], testActivities, testSubject)
        # Combine train and test data
        readyData <- rbind(readyTrain, readyTest)
        # Set activity names
        readyData$Activity <- activitiesMap$activityName[match(readyData$Activity, activitiesMap$activityID)]
        readyData
}

run_analysis<-function()
{
        library(reshape2)
        # Getting raw data
        getRawData()
        
        # Preparing the file list to process
        mFileList <- data.frame(activitiesName = "UCI HAR Dataset/activity_labels.txt",
                                variablesName = "UCI HAR Dataset/features.txt",
                                testData = "UCI HAR Dataset/test/X_test.txt",
                                testActivities = "UCI HAR Dataset/test/y_test.txt",
                                testSubject = "UCI HAR Dataset/test/subject_test.txt",
                                trainData = "UCI HAR Dataset/train/X_train.txt",
                                trainActivities = "UCI HAR Dataset/train/y_train.txt",
                                trainSubject = "UCI HAR Dataset/train/subject_train.txt",
                                stringsAsFactors = FALSE)
        # Get ready data
        readyData <- prepareData(mFileList)
        
        # Cast subject to factor for melting with activities
        readyData$Subject <- as.factor(readyData$Subject)
        # Melt the data set
        meltedData <- melt(readyData, id = c("Activity", "Subject"))
        # Cast data set taking the mean values of variables
        finalData <- dcast(meltedData, Subject + Activity ~ variable, mean)
        # Save the final data set
        write.table(finalData, file="./tidy_data.txt", row.names = FALSE)
}

