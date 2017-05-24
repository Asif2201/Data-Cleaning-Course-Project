# Script to combine and clean data based on the data set provided by: 
# Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
# using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions 
# for its use or misuse. Any commercial use is prohibited.
# Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
# The script does the following actions to produce the clean data set
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# the data must be in directory UCI HAR Dataset located in the working directory

library(sqldf)
# Load reference data for activities and features
Featuredf <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ",  stringsAsFactors = FALSE)
ActDF <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)
colnames(ActDF)[2] <- "activitydescription"

# Load and organise the Test data set
# Load activities and subjects for the test data set only 1 column so no processing required
Ydf <- read.csv("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
subdf <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Load observations from Test Data set into a string
filename <- "./UCI HAR Dataset/test/X_test.txt"
filecontent <- readChar(filename, file.info(filename)$size)
# convert the string into a list of variables
fileconentl <- strsplit(filecontent, " ")
# clean the list by removing empty observations added due to extra spaces in the file
cleanlist <- fileconentl[[1]]
cleanlist <- cleanlist[nchar(cleanlist)> 0]
# call the splitpernewline function to create a data frame from the list with each observation breaking where CR LF character is found
dataDF <- splitpernewline(cleanlist)

# Add details variable name
colnames(dataDF) <- Featuredf[,2]
# Extract only mean and standard deviation variables 
OnlyMeanSTD <- dataDF[,grep("mean\\(\\)|std\\(\\)" , Featuredf[,2])]
# Add subject and activity as columns into the data set
OnlyMeanSTD$subject <- subdf$V1
OnlyMeanSTD$activity <- Ydf$V1
# Join with the activity detail table to get activity descriptions
ActivitydetailsTestDF <- sqldf("select * from OnlyMeanSTD INNER JOIN ActDF ON activity = V1")
# Remove the duplicated activity number column
ActivitydetailsTestDF$V1 <- NULL

# Repeat all same steps for Training data set
Ydf <- read.csv("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
subdf <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
filename <- "./UCI HAR Dataset/train/X_train.txt"
filecontent <- readChar(filename, file.info(filename)$size)
fileconentl <- strsplit(filecontent, " ")
cleanlist <- fileconentl[[1]]
cleanlist <- cleanlist[nchar(cleanlist)> 0]
dataDF <- splitpernewline(cleanlist)
colnames(dataDF) <- Featuredf[,2] 
OnlyMeanSTD <- dataDF[,grep("mean\\(\\)|std\\(\\)" , Featuredf[,2])]
OnlyMeanSTD$subject <- subdf$V1
OnlyMeanSTD$activity <- Ydf$V1
ActivitydetailsTrainDF <- sqldf("select * from OnlyMeanSTD INNER JOIN ActDF ON activity = V1")
ActivitydetailsTrainDF$V1 <- NULL

# Combine the cleaned Test and Training data set
ActivitydetailsDF <- rbind(ActivitydetailsTrainDF, ActivitydetailsTestDF)

# Take average values of each variable grouped per subject and activity
cleanDF <- aggregate(x = ActivitydetailsDF[,1:66], by = list(ActivitydetailsDF$subject, ActivitydetailsDF$activity, ActivitydetailsDF$activitydescription), FUN = "mean")
cleanDF <- cleanDF[order(cleanDF$Group.1, cleanDF$Group.2, cleanDF$Group.3),]
# Add to column name AvgOf to make it readable
colnames(cleanDF)[4:69] <- paste("AvgOf",colnames(cleanDF)[4:69])
# Correct the group by column names 
colnames(cleanDF)[1] <- "subject"
colnames(cleanDF)[2] <- "activity"
colnames(cleanDF)[3] <- "activitydescription"
# write it to a text file
write.table(x = cleanDF, file = "cleandataset.txt", row.names = FALSE)


# Function to convert a list of strings into a data frame splitting when a CRLF character is found in the string
# input parameters x : List of strings
splitpernewline <- function(x)     {
        startingindex = 1
        # find indices where CR LF character is found
        IndiceswithNewLine = grep("\r\n", x)
        # create an empty matrix of specificied rows and columns
        ReturnMatrix <- matrix(0, ncol = 561, nrow = length(IndiceswithNewLine))
        # Add rows to the Matrix with string ending where CR LF is found 
        for(i in 1 : length(IndiceswithNewLine)) {
                y <- x[startingindex:IndiceswithNewLine[i]]    
                startingindex <- IndiceswithNewLine[i] + 1
                # add into matrix as numeric which also removes the CR LF characters
                ReturnMatrix[i, ] <- as.numeric(y)
        }
        #return the matrix as data frame without factoring
        data.frame(ReturnMatrix, stringsAsFactors = FALSE)
}