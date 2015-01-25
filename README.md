# get-clean-project
Coursera getting and cleaning data course project repository

# Workings of the file: run_analysis.R

The script assumes that the dplyr library is installed.
It looks for the datafiles in the "UCI HAR Dataset" directory for the datafiles

Sourcing the file is enough to run all necessary steps for creating a tidy dataset which is saved in the current directory.

It initialy reads the necessary files into R memory
Then the test and train data is merged into the "_all" suffixed variables, and the columns are named according to the features file factors.

Then the preliminary structure with subject, activity and the columns ending in mean() or std() is created.
The subject column is changed to factors and the activities are changed to readable activity labels.

# basis dataset
The basis for the analysis is now in the X_struct data.

# analysis
The means of the columns go into the X_means data, which is done with the  aggregate function and the data is sorted by activity first, and person next.

This order seems the most logic because now the same activities of the differect subjects can be easily compared.
The script finally saves the data to a file called: "tidy_dataset.txt" 

For sake of clarity and inspectability all intermediary data is kept in memory and not removed.

the dataset is easily viewed in RStudio with:

> data <- read.table("tidy_dataset.txt", header=TRUE)
> View(data)