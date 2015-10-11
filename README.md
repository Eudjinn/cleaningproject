# The Code book for the "Getting and Cleaning Data" course project

## Repository contents

All the data that is needed for this course project is saved in this repository. 
Below is the list of files and folders with short descriptions:

| File/Folder      | Description                                                                      |
|------------------|----------------------------------------------------------------------------------|
| CodeBook.md      | Code book with data transformation and variables description                     |
| README.md        | This file                                                                        |
| UCI HAR Dataset  | The RAW data set which is used by run_analysis.R to produce tidy dataset.        |
| run_analysis.R   | R script which loads RAW data, makes transformations and makes the tidy data set.|
| tidy\_dataset.txt | The tidy dataset which is produced by runAnalysis function from run\_analysis.R | 

## Using the script

1. Clone the repository to your machine where R and RStudio are installed and configured. It is expected that all the pachages and libraries that are needed for the script to work are installed and loaded. This should be the case for everyone who is doing the course anyway.
2. Set the working directory in RStudio to the folder where the repository contents have been cloned, so that run_analysis.R is in that folder along with the rest of the files.
3. Load the script: 
\> source("run_analysis.R")
4. Run the script:
\> runAnalysis()
5. View the result: 
new file named "tidy_dataset.txt" should be produced as a result. The sample file is included in this repository, so please check the creation date and time to make sure that this file is the new result.