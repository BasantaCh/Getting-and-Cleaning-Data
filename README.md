For the project the ziped folder from the website https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
was downloaded and correspondinlgy following task were performed on the dataset to get the tidy dataset.

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The data for the test and train are located in the separate folder and this data needs to be merged into a single file.
For this, the features and activity lables from the features file and activity file in txt format were read into R and is used to describe
the feature data that were retrived from the train and test file.  

The grep function is used to extract the mean and standard deviation for each of the measurement.
Before loading the code in R, make sure the library data.table and reshape2 is installed in your environment. 
