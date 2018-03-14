###################
#OUR BEER APP
#Caitlin & Mario 
##################

library(shiny)
library(tidyverse)
library(leaflet)
library(sf)
library(shinythemes)


tot_beer_final <- read_csv("tot_beer.csv") %>% 
  mutate(abv_percent = 100*abv)
style_beer <- read_csv("style_beer.csv")

tot_beer <- merge(tot_beer_final, style_beer)


BeerIcon <- makeIcon(
  iconUrl = "http://i.imgur.com/NOWSVBu.png",
  iconWidth = 30, iconHeight = 30,
  iconAnchorX = 10, iconAnchorY = 10
  
)


tot_beer_sf <- st_as_sf(tot_beer, coords = c("longitude", "latitude"), crs = 4326)


ui <- fluidPage(theme = shinytheme("superhero"),

                h2("Prowler for a Growler", style = "font-family: 'Jura'; color: red; font-size: 64px;"),
                
                sidebarLayout(
                  sidebarPanel(
                    
                    selectInput("type", 
                                "Beer Preference", 
                                choices = unique(tot_beer$group),
                                selected = "Ale"),
                    
                    radioButtons("loc", label = "State",
                                 choices = unique(tot_beer$state),
                                 selected = "ME"),
                    verbatimTextOutput("value"),
                    h3("Source: Jean-Nicholas Hould. (2017). Craft Beers Dataset (Version 1). Retrieved from https://www.kaggle.com/nickhould/craft-cans/data.", style = "color = red; font-size: 12px;")
                    ),
                  
                  mainPanel(
                    leafletOutput("beer_map")
                  )
                )
)

server <- function(input, output) {
  
  output$beer_map <- renderLeaflet({
    
    beer_sub <- tot_beer %>% 
      filter(state == input$loc & group == input$type)
    
    leaflet(beer_sub) %>% 
      addTiles() %>% 
      addMarkers(lng = beer_sub$longitude, 
                 lat = beer_sub$latitude,
                 popup = paste(sep="", 
                               "<font size = 2 color = red>", 
                               "Brewery: ","</font>", 
                               "<font size = 2 color = black>", 
                               beer_sub$brew_name,"</font>", 
                               "<br/>", 
                               "<font size = 2 color = red>", 
                               "Beer Name: ","</font>", 
                               "<font size = 2 color = black>", 
                               beer_sub$name,"</font>",
                               "<br/>", 
                               "<font size = 2 color = red>", 
                               "Specific Beer Style: ","</font>", 
                               "<font size = 2 color = black>", 
                               beer_sub$style, "</font>",
                               "<br/>", 
                               "<font size = 2 color = red>", 
                               "Alcohol by Volume: ","</font>", 
                               "<font size = 2 color = black>", 
                               beer_sub$abv_percent," %","</font>",
                               "</b>"),
                 icon = BeerIcon)
    
  })
  
  observe({
    proxy <- leafletProxy("beer_map") %>% 
      fitBounds(-71.8,41,-69,47.255)
  })
  
  
}

shinyApp(ui = ui, server = server)

