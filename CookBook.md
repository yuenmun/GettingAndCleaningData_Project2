Getting and Cleaning Data Project 2

Cookbook for run_analysis.R script

The raw data set provided 

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope.
3. 561-feature vector with time and frequency domain variables.
4. Its activity label.
5. Identifier of the subject who carried out the experiment.

Steps
1. Read training data into R
2. Add training Label into training data
3. Add Subject details into training data
4. Perform the same step 1-3 for testing data.
5. Read activityLabels data
6. Read features label data and perform clean up. (Remove spaces, dashes)
7. Merge both testing and training data.
8. Subset data with only measurements on the mean and standard deviation
9. Replace activity which is in the form of number to actual activity name
10. Aggregate the data and perform mean calculation
11. Write the table and save the data in tidydata.txt



