==================================================================
Clean data set is based on the data set "Human Activity Recognition Using Smartphones Dataset
Version 1.0" as licensed under
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
===================================================================


For each record it is provided:
======================================
- A 66-feature vector for each of the 30 subjects with subject identifier, decription of the activity and mean and standard deviation of measurments for 
        -  the Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
        - Mean and standard deviation for the Triaxial Angular velocity from the gyroscope. 

The dataset includes the following files:
=========================================

- 'README.md'
- 'Codebook.md': Shows information on the clean data set and steps taken to derive from original data set.
- 'cleandataset.txt': clean data set of observations.
- 'run_analysis.R: R script which can be executed to reproduce the clean data set. the original data set folder 'UCI HAR Dataset' needs to be in the working directory of R for this script to run. SQLDF package is also required and will be loaded within the script. 
- Directory 'UCI HAR Dataset' containing all the orignial files and descriptions 
- for any questions on the script please email me at asif.rafat@gmail.com or asifrafatkhan@me.com