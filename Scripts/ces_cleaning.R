#### Preamble ####
# Purpose: Prepare and clean the CES online survey data
# Author: Zakir Chaudry
# Date: 13 December 2020
# Contact: zakir.chaudry@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from the CES and save the folder that you're 
# interested in to inputs/raw data 
# - Don't forget to gitignore it!

#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("Inputs/Raw Data/dataverse_files/2019 Canadian Election Study - Online Survey v1.0.dta")
# Add the labels
ces <- labelled::to_factor(raw_data)
ces <- ces %>% select(cps19_age,
               cps19_education,
               cps19_gender,
               cps19_province,
               cps19_votechoice)

ces$age_range <- NA
ces$age_range <- cut(ces$cps19_age, breaks = c(-Inf, 25, 35, 45, 55, 65, 75, Inf),
                     labels = c("18 to 24","25 to 34","35 to 44",
                                "45 to 54","55 to 64","65 to 74",
                                "75 and above"))

ces$education <- NA
ces$education <- as.character(ces$cps19_education)
ces$education[ces$education == "No schooling"] <- "Less than High School"
ces$education[ces$education == "Some elementary school"] <- "Less than High School" 
ces$education[ces$education == "Completed elementary school"] <- "Less than High School"
ces$education[ces$education == "Some secondary/ high school"] <- "Less than High School"
ces$education[ces$education == "Completed secondary/ high school"] <- "High School"
ces$education[ces$education == "Some technical, community college, CEGEP, College Classique"] <- "Less than Bachelor's Degree"
ces$education[ces$education == "Completed technical, community college, CEGEP, College Classique"] <- "Less than Bachelor's Degree" 
ces$education[ces$education == "Some university"] <- "Less than Bachelor's Degree"
ces$education[ces$education == "Bachelor's degree"] <- "Bachelor's Degree"
ces$education[ces$education == "Master's degree"] <- "Above Bachelor's Degree"
ces$education[ces$education == "Professional degree or doctorate"] <- "Above Bachelor's Degree"
ces$education[ces$education == "Don't know/ Prefer not to answer"] <- "N/A"
ces <- ces %>% filter(ces$education != "N/A")
ces$education <- as.factor(ces$education)

ces$gender <- NA
ces$gender <- as.character(ces$cps19_gender)
ces$gender[ces$gender == "A man"] <- "Male"
ces$gender[ces$gender == "A woman"] <- "Female"
ces <- ces %>% filter(gender != "Other (e.g. Trans, non-binary, two-spirit, gender-queer)")
ces$gender <- as.factor(ces$gender)

ces <- ces %>% filter(cps19_province != "Yukon", 
                      cps19_province != "Nunavut", 
                      cps19_province != "Northwest Territories")

ces <- ces %>% filter(ces$cps19_votechoice != "Another party (please specify)", 
                      ces$cps19_votechoice != "Don't know/ Prefer not to answer")

ces$cps19_votechoice <- as.character(ces$cps19_votechoice)
ces$Green <- NA
ces$Green[ces$cps19_votechoice == "Green Party"] = 1
ces$Green[ces$cps19_votechoice != "Green Party"] = 0
ces$Green <- as.numeric(ces$Green)

ces$Conservative <- NA
ces$Conservative[ces$cps19_votechoice == "Conservative Party"] = 1
ces$Conservative[ces$cps19_votechoice != "Conservative Party"] = 0
ces$Conservative <- as.numeric(ces$Conservative)

ces$Liberal <- NA
ces$Liberal[ces$cps19_votechoice == "Liberal Party"] = 1
ces$Liberal[ces$cps19_votechoice != "Liberal Party"] = 0
ces$Liberal <- as.numeric(ces$Liberal)

ces$Peoples <- NA
ces$Peoples <- ces$cps19_votechoice
ces$Peoples[ces$cps19_votechoice == "People's Party"] = 1
ces$Peoples[ces$cps19_votechoice != "People's Party"] = 0
ces$Peoples <- as.numeric(ces$Peoples)

ces$Bloc <- NA
ces$Bloc <- ces$cps19_votechoice
ces$Bloc[ces$cps19_votechoice == "Bloc Québécois"] = 1
ces$Bloc[ces$cps19_votechoice != "Bloc Québécois"] = 0
ces$Bloc <- as.numeric(ces$Bloc)

ces$NDP <- NA
ces$NDP <- ces$cps19_votechoice
ces$NDP[ces$cps19_votechoice == "ndp"] = 1
ces$NDP[ces$cps19_votechoice != "ndp"] = 0
ces$NDP <- as.numeric(ces$NDP)

ces <- ces %>% select(cps19_votechoice,
                      age_range,
                      education,
                      gender,
                      cps19_province,
                      Green,
                      Conservative,
                      Liberal,
                      Peoples,
                      Bloc,
                      NDP)

# Save as csv
write_csv(ces, "Inputs/Cleaned Data/ces.csv")
