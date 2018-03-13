###################
#OUR BEER APP
#Caitlin & Mario 
##################


library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

tot_beer <- read_csv("tot_beer.csv")

#CA_beer set as simple feature for projection in leaflet

tot_beer_sf <- st_as_sf(tot_beer, coords = c("longitude", "latitude"), crs = 4326)
 

# Define UI for application that draws a map
ui <- fluidPage(
   
   # Application title
   titlePanel("Prowler for a Growler"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
    
        selectInput("type", 
                    "Beer Preference", 
                    choices = unique(tot_beer$style),
                    selected = "American IPA"),

        radioButtons("loc", label = "State",
                      choices = unique(tot_beer$state),
                      selected = "ME"),
        verbatimTextOutput("value")),
      
    
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("beer_map")
      )
   )
)

# Define server logic required to draw an interactive map
server <- function(input, output) {
   
   output$beer_map <- renderLeaflet({
     
     beer_sub <- tot_beer %>% 
       filter(state == input$loc & style == input$type)
     
     leaflet(beer_sub) %>% 
       addTiles() %>% 
       addMarkers(lng = beer_sub$longitude, 
                  lat = beer_sub$latitude,
                  popup = c(beer_sub$brew_name, beer_sub$style))
     
   })
   
   observe({
     proxy <- leafletProxy("beer_map") %>% 
       fitBounds(-71.8,41,-69,47.255)
   })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

