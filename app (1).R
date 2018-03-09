###################
#OUR BEER APP
#Caitlin & Mario 
##################


library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

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
                    choices = unique(tot_beer$style)),

        checkboxGroupInput("loc", label = "State",
                      choices = unique(tot_beer$state),
                      FALSE),
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
       addMarkers()
     
     
   })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

