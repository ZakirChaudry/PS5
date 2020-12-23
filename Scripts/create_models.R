#### Preamble ####
# Purpose: Creates models based on CES data
# Author: Zakir Chaudry
# Date: 22 December 2020
# Contact: zakir.chaudry@mail.utoronto.ca
# License: MIT
# Prerequisites: All other scripts have been ran

# Read data
ces <- read.csv("Inputs/Cleaned Data/ces.csv")

# Workspace Setup
library(brms)
library(tidyverse)

# Create each model

Green_model <- brm(Green ~ age_range + education + gender + cps19_province,
             data = ces,
             family = bernoulli())

Conservative_model <- brm(Conservative ~ age_range + education + gender + cps19_province,
                   data = ces,
                   family = bernoulli())

Liberal_model <- brm(Liberal ~ age_range + education + gender + cps19_province,
                   data = ces,
                   family = bernoulli())

Peoples_model <- brm(Peoples ~ age_range + education + gender + cps19_province,
                   data = ces,
                   family = bernoulli(),
                   prior = prior)

Bloc_model <- brm(Bloc ~ age_range + education + gender + cps19_province,
                   data = ces,
                   family = bernoulli())

NDP_model <- brm(NDP ~ age_range + education + gender + cps19_province,
                   data = ces,
                   family = bernoulli())

# Save each model

saveRDS(Green_model, file = "Inputs/Models/Green.rds")
saveRDS(Conservative_model, file = "Inputs/Models/Conservative.rds")
saveRDS(Liberal_model, file = "Inputs/Models/Liberal.rds")
saveRDS(Peoples_model, file = "Inputs/Models/Peoples.rds")
saveRDS(Bloc_model, file = "Inputs/Models/Bloc.rds")
saveRDS(NDP_model, file = "Inputs/Models/NDP.rds")
