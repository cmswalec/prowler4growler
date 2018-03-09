
library(tidyverse)

beers <- read_csv("beers.csv")
brews <- read_csv("breweries.csv")

full_beer_list <- merge(beers, brews)
CA <- full_beer_list %>% 
  filter(state == "CA")

cities <- read_csv("uscitiesv1.3.csv")
cities2 <- cities %>% 
  filter(state_id_x == "CA")

CA_beer <- merge(CA, cities2, by.x = "city", by.y = "city_x") %>% 
  select("city", "abv", "ibu", "name", "style", "brew_name", "lat", "lng")

write.csv(CA_beer, "CA_beer.csv")