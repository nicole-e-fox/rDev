##Coursera Getting and Cleaning Data Course Project

The source data file and associated documentation is archived The UCI Machine Learning Repository
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# 

Please refer to the source documentation and associated README.txt file accompanying the data for more information to ensure accuracy.   

The means and standard deviations for each measurement were programmatically subset for mean(): Mean value and std(): Standard deviation.

**Notes on variable names:** 

 - 'f' denotes frequency domain signals
 - 'FFT' indicatesFast Fourier Transform 

**Output Details**

Averages (means) were then calculated per subject per activity (i.e. variable MeanSamples in output data.)

- The output file, tidy.output.means, is a hierarchical .txt file including consisting of six observations for 30 subjects for a total record count of 180 (N=180) and a header row for a total line count of 181.  
- Variables include Subject (i.e. Subject ID number), Activity, and Meansamples
