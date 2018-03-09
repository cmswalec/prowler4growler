
library(tidyverse)

beers <- read_csv("beers.csv")
brews <- read_csv("breweries.csv")

full_beer_list <- merge(beers, brews)
cities <- read_csv("uscitiesv1.3.csv")


#MA

MA <- full_beer_list %>% 
  filter(state == "MA")

citiesMA <- cities %>% 
  filter(state_id_x == "MA")

MA_beer <- merge(MA, citiesMA, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(MA_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

#CT

CT <- full_beer_list %>% 
  filter(state == "CT")

citiesCT <- cities %>% 
  filter(state_id_x == "CT")

CT_beer <- merge(CT, citiesCT, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(CT_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

#RI

RI <- full_beer_list %>% 
  filter(state == "RI")

citiesRI <- cities %>% 
  filter(state_id_x == "RI")

RI_beer <- merge(RI, citiesRI, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(RI_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

#VT

VT <- full_beer_list %>% 
  filter(state == "VT")

citiesVT <- cities %>% 
  filter(state_id_x == "VT")

VT_beer <- merge(VT, citiesVT, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(VT_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

#NH

NH <- full_beer_list %>% 
  filter(state == "NH")

citiesNH <- cities %>% 
  filter(state_id_x == "NH")

NH_beer <- merge(NH, citiesNH, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(NH_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

#ME

ME <- full_beer_list %>% 
  filter(state == "ME")

citiesME <- cities %>% 
  filter(state_id_x == "ME")

ME_beer <- merge(ME, citiesME, by.x = "city", by.y = "city_x") %>% 
  select("state", "city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

colnames(ME_beer) <- c("state", "city", "abv", "ibu", "name", "style", "brew_name", "latitude", "longitude")

tot_beer <- rbind(CT_beer, MA_beer, RI_beer, VT_beer, NH_beer, ME_beer)


write.csv(tot_beer, "tot_beer.csv")
