# Background

The hosted data and scripts were used as part of a study that merged AnnAGNPS simulations of prairie potholes, risk theory, and random forest machine learning to create a flood risk prediction ranking system for farmed prairie potholes in the Des Moines Lobe of Iowa. This data and model were incorporated into the PPMST (Prairie Pothole Management Support Tool), a R Shiny App developed by Brady Nahkala. This tool is hosted on GitHub and the Shiny Servers. 

# Data

The primary data hosted here includes csv files of 25-year daily output of water levels simulated in AnnAGNPS for 6 prairie potholes (1 pothole per csv file). Input data for the AnnAGNPS models is not included in this study. The data is presented as a time series with the first four columns representing the date stamp. The following ~40 columns are output from various simulations of alternative management, using the same pothole water structure, but changing management parameters. These scenarios are filtered in the scripts to include only scenarios of interest for the studies and for model development. 

# Scripts

Four scripts include the data preprocessing and random forest model development. 

1. This imports the data and creates the data summaries. It creates the 'true' risk ranking and then calibrates and validates the random forest model. 
2. This script is used to manually check how removing predictor variables influences model performance. 
3. This script requires the user to declare the final model parameters. 
4. This script is a partial analysis of the random forest model. 

# Graphics

Some of these scripts also generate graphics utilized in the my thesis, instead of being hosted in the main aggregated repo that I have created titled 'thesis-data-processing.' This is because it is difficult to export the entire model structure to a usable (read: importable) format that isn't an R object. The graphics in this repo (and their relative locations within the scripts) include:
 1. 02_InputReduction.R - which creates the data for Table 4 of Chapter 4. 
 2. 04_ModelAnalysis.R - see lines 99-14 for the direct generation of Figures 5 and 6 of Chapter 4 within my thesis. One of these requires the function in the plotNodeDepth.R script. 
 3. 44_Ch4_Cv.Rmd - this predictably creates Figure 4 of Chapter 4, per the naming conventions I established in 'bnahkala/thesis-data-processing.'
