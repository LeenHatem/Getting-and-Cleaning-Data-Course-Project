# Getting-and-Cleaning-Data-Course-Project

This script processes the UCI HAR dataset to create a tidy dataset.

## Steps:
1. Read and clean merged training and test sets.
2. Extract mean and standard deviation columns.
3. Create a tidy dataset with averages for each activity and subject and save it to the file `tidy_data.txt`.

## How to Run:
1. Install `dplyr` package.
2. Set the working directory to the Dataset location.
3. Run the script:

```r
source("run_analysis.R")
