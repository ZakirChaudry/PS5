#### Preamble ####
# Purpose: Applies post-stratification on the GSS data
# Author: Zakir Chaudry
# Date: 22 December 2020
# Contact: zakir.chaudry@mail.utoronto.ca
# License: MIT
# Prerequisites: All other scripts have been ran

# Reads Data
gss <- read.csv("Inputs/Cleaned Data/gss.csv")

# Reads Models
Green_model <- readRDS("Inputs/Models/Green.rds")
Conservative_model <- readRDS("Inputs/Models/Conservative.rds")
Liberal_model <- readRDS("Inputs/Models/Liberal.rds")
Peoples_model <- readRDS("Inputs/Models/Peoples.rds")
Bloc_model <- readRDS("Inputs/Models/Bloc.rds")
NDP_model <- readRDS("Inputs/Models/NDP.rds")

# Makes predictions on each model
green <- Green_model %>% predict(newdata = gss)
conservative <- Conservative_model %>% predict(newdata = gss)
Liberal <- Liberal_model %>% predict(newdata = gss)
Peoples <- Peoples_model %>% predict(newdata = gss)
Bloc <- Bloc_model %>% predict(newdata = gss)
NDP <- NDP_model %>% predict(newdata = gss)

# List of Parties
parties <- c("Green Party", "Conservative Party", "Liberal Party", "People's Party", "Bloc Québécois", "NDP")

# List of Respective Predictions
predictions <- data.frame(green[,1], conservative[,1], Liberal[,1], Peoples[,1], Bloc[,1], NDP[,1])

# For each GSS Observation
for (num_row in 1:nrow(gss)) {
  # Max probability
  max <- 0
  # Index of Most Likely Party in parties
  party_i <- 0
  for (i in 1:6) {
    prediction <- predictions[num_row, i]
    if (prediction > max) {
      # New max
      max <- prediction
      # New Most Likely Party
      party_i <- i
    }
  }
  # Saves Most Likely Party
  gss$party[num_row] <- parties[party_i]
}

# Writes back to the GSS csv
write_csv(gss, "Inputs/Cleaned Data/gss.csv")


