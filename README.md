# Getting-and-Cleaning-Data-Assignment
The run_analysis.R scripts is a program that reads and combines data from the "Human Activity Recognition Using Smartphones Dataset Version 1.0" creating a new tidy dataset. 

The data were collected from experiments where 30 volunteers participated in six activities (walking, walking upstairs, walking downstairs, standing, sitting, and lying) while wearing a Samsung Galaxy S II on their hips. From motion, acceleration, and positioning programming data were collected.

## run_analysis.R Script Description

 - The data files (features.txt, activity_labels.txt, X_train.txt, y_train.txt, 
    subject_train.txt, X_test.txt, y_test.txt, subject_text.txt) are first read in
    and labeled
 - The test and training data sets are combined into one dataframe
 - The columns with "mean" and "std" in their names are extracted, using the 
    grep function
 - The merge function is used to merge the descriptive names with the mean/std 
    datasets and that new tidy dataset is then saved to tidy_movement_data.txt. 
    
   
