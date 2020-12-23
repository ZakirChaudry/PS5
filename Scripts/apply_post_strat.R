gss <- read.csv("Inputs/Cleaned Data/gss.csv")
ces <- read.csv("Inputs/Cleaned Data/ces.csv")

gss <- gss %>% filter(education != "N/A")
gss$gender <- gss$sex
gss$cps19_province <- gss$province

Green_model <- readRDS("Inputs/Models/Green.rds")
Conservative_model <- readRDS("Inputs/Models/Conservative.rds")
Liberal_model <- readRDS("Inputs/Models/Liberal.rds")
Peoples_model <- readRDS("Inputs/Models/Peoples.rds")
Bloc_model <- readRDS("Inputs/Models/Bloc.rds")
NDP_model <- readRDS("Inputs/Models/NDP.rds")

green <- Green_model %>% predict(newdata = gss)
conservative <- Conservative_model %>% predict(newdata = gss)
Liberal <- Liberal_model %>% predict(newdata = gss)
Peoples <- Peoples_model %>% predict(newdata = gss)
Bloc <- Bloc_model %>% predict(newdata = gss)
NDP <- NDP_model %>% predict(newdata = gss)

parties <- c("Green Party", "Conservative Party", "Liberal Party", "People's Party", "Bloc Québécois", "NDP")
predictions <- data.frame(green[,1], conservative[,1], Liberal[,1], Peoples[,1], Bloc[,1], NDP[,1])

for (num_row in 1:nrow(gss)) {
  max <- 0
  party_i <- 0
  for (i in 1:6) {
    prediction <- predictions[num_row, i]
    if (prediction > max) {
      max <- prediction
      party_i <- i
    }
  }
  gss$party[num_row] <- parties[party_i]
}

write_csv(gss, "Inputs/Cleaned Data/gss.csv")


