This repository contains code and data supporting the analysis outlined in 'Liberal Party Could Have Attained Majority If All Eligible Voters Had Voted in the 2019 Canadian Federal Election'. 

The two datasets are either too large or too private to share via the repository, but instructions have been outlined in each respective cleaning script, located in the scripts folder.

Inputs/Raw Data and Inputs/Cleaned Data are two folders that won't exist due to git tracking files rather than directories, so you will have to make
those on your own prior to cleaning.

Inputs/Models are where the models created are stored.

Outputs is where files relating to actual report itself are located (namely the Rmd file, the bib file, and the outputs of such)

Scripts contains four scripts relating to the report. 
The two cleaning scripts clean the data (again, you will have to manually download the raw based on the instructions).
The "create_models.R" script creates the models required for analysis based on the cleaned data.
The "apply_post_strat.R" script applies the post-stratification on the GSS data using the model created from the last script.