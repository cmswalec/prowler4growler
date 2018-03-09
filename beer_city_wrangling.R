

beers <- read.csv("beers.csv")
brews <- read.csv("breweries.csv")


full_beer_list <- merge(beers, brews)
full_beer_list$city_state <- paste(full_beer_list$city, full_beer_list$state)

write.csv(full_beer_list, "full_beer_list.csv")


cities <- read.csv("uscitiesv1.3.csv")
#cities$city_state <- paste(cities$city_x, cities$state_id_x)

cities2 <- unite(cities, newcol, c(city_x, state_id_x), remove = FALSE)

list_with_spatial <- merge(full_beer_list, cities, by.x = 'city', by.y = 'city_x')
