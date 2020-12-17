gss <- read.csv("Inputs/Cleaned Data/gss.csv")
ces <- read.csv("Inputs/Cleaned Data/ces.csv")

# Create Model

library(brms)
library(tidyverse)

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

prior <- prior(normal(0,1))


saveRDS(Green_model, file = "Inputs/Models/Green.rds")
saveRDS(Conservative_model, file = "Inputs/Models/Conservative.rds")
saveRDS(Liberal_model, file = "Inputs/Models/Liberal.rds")
saveRDS(Peoples_model, file = "Inputs/Models/Peoples.rds")
saveRDS(Bloc_model, file = "Inputs/Models/Bloc.rds")
saveRDS(NDP_model, file = "Inputs/Models/NDP.rds")
