Abstract: 

A clean data set with averages for mean and standard deviation of measurements from the Human Activity Recognition database. The database was originally built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

License information of the original data set:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

The cleaned data set is based on the mean and standard deviation variables and takes the average of the 2 estimates across each subject and activity.

The "cleandataset.txt" has 180 observations for 69 variables with space used as field separator. 

The observations are for each of the 30 subjects measured while performing the 6 given activities as follows:
       
       1 WALKING
       2 WALKING_UPSTAIRS
       3 WALKING_DOWNSTAIRS
       4 SITTING
       5 STANDING
       6 LAYING



Variable Name and descriptions 

1. subject:                     ID of the subject wearing the smartphone 
2. activity:                    ID of the activity being performed
3. activitydescription:         Description of the activity performed 
4-69:  
The average mean and standard deviation readings for each person and activity as recorded for the below data points from the original data set 
 (for more details on these readings refer to the features_info.txt and features.txt file)

1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z

41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z
44 tGravityAcc-std()-X
45 tGravityAcc-std()-Y
46 tGravityAcc-std()-Z

81 tBodyAccJerk-mean()-X
82 tBodyAccJerk-mean()-Y
83 tBodyAccJerk-mean()-Z
84 tBodyAccJerk-std()-X
85 tBodyAccJerk-std()-Y
86 tBodyAccJerk-std()-Z

121 tBodyGyro-mean()-X
122 tBodyGyro-mean()-Y
123 tBodyGyro-mean()-Z
124 tBodyGyro-std()-X
125 tBodyGyro-std()-Y
126 tBodyGyro-std()-Z

161 tBodyGyroJerk-mean()-X
162 tBodyGyroJerk-mean()-Y
163 tBodyGyroJerk-mean()-Z
164 tBodyGyroJerk-std()-X
165 tBodyGyroJerk-std()-Y
166 tBodyGyroJerk-std()-Z

201 tBodyAccMag-mean()
202 tBodyAccMag-std()

214 tGravityAccMag-mean()
215 tGravityAccMag-std()

227 tBodyAccJerkMag-mean()
228 tBodyAccJerkMag-std()

240 tBodyGyroMag-mean()
241 tBodyGyroMag-std()

253 tBodyGyroJerkMag-mean()
254 tBodyGyroJerkMag-std()

266 fBodyAcc-mean()-X
267 fBodyAcc-mean()-Y
268 fBodyAcc-mean()-Z
269 fBodyAcc-std()-X
270 fBodyAcc-std()-Y
271 fBodyAcc-std()-Z

345 fBodyAccJerk-mean()-X
346 fBodyAccJerk-mean()-Y
347 fBodyAccJerk-mean()-Z
348 fBodyAccJerk-std()-X
349 fBodyAccJerk-std()-Y
350 fBodyAccJerk-std()-Z

424 fBodyGyro-mean()-X
425 fBodyGyro-mean()-Y
426 fBodyGyro-mean()-Z
427 fBodyGyro-std()-X
428 fBodyGyro-std()-Y
429 fBodyGyro-std()-Z

503 fBodyAccMag-mean()
504 fBodyAccMag-std()

516 fBodyBodyAccJerkMag-mean()
517 fBodyBodyAccJerkMag-std()

529 fBodyBodyGyroMag-mean()
530 fBodyBodyGyroMag-std()

542 fBodyBodyGyroJerkMag-mean()
543 fBodyBodyGyroJerkMag-std()



Process and transformation steps to make this clean data set:

The original data set contains:
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


The R script first organises and cleans the test data and train data separately and then merges the 2 data sets. The following steps are taken for the merging and cleaning.

Step 1: Reference data
Load reference data sets of features and activities to combine with test and training data for meaningful name of variables and activity descriptions.

Step 2: Test and Train data
2a.	Subject and activity list is simply loaded as 1 column data frames
2b.	Actual observation data as stored in X_test (or X_train) file is stored as 1 line per 561 recorded observations (refer to features.txt for the list of observations in the file). Each record is separated by CR LF characters. In order to process it correctly into R Data Frame, the whole file is loaded into a string variable. 
2c.	The string is then converted into a list of strings using space character as separator.
2d.	All empty strings from the list of strings are removed by sub-setting the list to values where length of string is greater than 0.
2e.	The list of strings is then converted into a data frame with observations as rows of data frame. A custom function splitpernewline() is used for this purpose and explained below.
2f.	Column names are updated by using the feature data frame loaded in step 1.
2g.	Further subset the data frame to take only mean and standard deviation variables. This is done by looking for strings "mean()" and "std()" in the column names.
2h.	The column containing subjects is added from the subject_test (or subject_train) file
2i.	The column containing activity id is added from the y_test (or y_train) file
2j.	Activity description is added by joining with the activity file loaded in step 1.

Step 3: Cleaned Test and Train data set is merged by using row binding

Step 4: Finalising the data set
4a.	A new data set is created by using the aggregate function with group by on subject, activity and activitydescription columns. All other variables are summarised using "mean()" function.

4b.	 Data is ordered using the group by fields (subject, activity, activity description)
4c.	 "AvgOf " is added to the column names of the observations and the group by columns are renamed to reflect the correct meaning i.e. subject, activity, activity description
4d.	 The final data set is exported as text file "cleandataset.txt"

Description of the function "splitpernewline(x)":
This function takes the list of strings as input parameter and looks for the string which contains "\r\n" character to split the row and add it into a Matrix variable. This is done in a loop until all characters with "\r\n" are found and matrix variable is filled with rows. The matrix variable is converted into data frame and returned.

