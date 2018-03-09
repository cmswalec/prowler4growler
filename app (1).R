###################
#My Fire App
#Caitlin
##################


library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

#CA_beer set as simple feature for projection in leaflet

CA_beer_sf <- st_as_sf(CA_beer, coords = c("longitude", "latitude"), crs = 4326)
 

# Define UI for application that draws a map
ui <- fluidPage(
   
   # Application title
   titlePanel("Prowler for a Growler"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
        selectInput("type", 
                    "Beer Preference", 
                    choices = unique(CA_beer$style)),
      
      textInput("text", 
                "California City",
                value = "Enter text...")),
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("beer_map")
      )
   )
)

# Define server logic required to draw an interactive map
server <- function(input, output) {
   
   output$beer_map <- renderLeaflet({
     
     beer_sub <- CA_beer %>% 
       filter(style == input$type & city == input$text)
     
     leaflet(beer_sub) %>% 
       addTiles() %>% 
       addMarkers()
     
     
   })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

