**Coursera Getting and Cleaning Data Course Project**

The source data file and associated documentation is archived The UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# 

Please refer to the source documentation and associated README.txt file accompanying the data for more information.  

The following requested transformations have been performed on this data in the Run_Analysis.R program. 

**1) Merge the training and the test sets to create one data set.**

- Load packages
- Set working directory
- Create working directory ref
- Create list to be populated with dataframes containing datain specficied files
- Read in features file using read.table
- Read in activity labels using read.table
- Read in test data read.table and merge using cbind 
- Read in train data using read.table and merge using cbind 

**2) Extract only the mean and standard deviation for each measurement.** 

- Append test and train data files using rbind and select requested variables (mean and standard deviation columns) using grep for each measurement

**3) Uses descriptive activity names to name the activities in the data set**

- Call in activity names and rename column names
- Include descriptive activity names using merge 

*4) Appropriately labels the data set with descriptive variable names*

- Dynamically assign feature column names using gsub (grep subsitution, i.e. find and replace) 

**5) Creates a tidy data set with the average of each variable for each activity and each subject.**

- Reorder columns for easier use / viewing in external tools (e.g. Excel)
- Sort the data by Subject/Activity for to increase output readability
- Create tidy data
- Create tidy means - Activity Means by Subject
- Output data to external file (if requested)
- Output means to external file
 
**Output Details**

- The output file, tidy.output.means, is a hierarchical .txt file including consisting of six observations for 30 subjects for a total record count of 180 (N=180) and a header row for a total line count of 181.  
- Variables include Subject (i.e. Subject ID number), Activity, and Meansamples
