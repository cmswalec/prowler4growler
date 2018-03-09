###################
#My Fire App
#Caitlin
##################


library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

sb_fhz <- st_read(dsn = ".", layer = "fhszs06_3_42")
# coordinate system originally NAD83 but we are going to reset to WGS94 b/c that's what open street maps uses

sb_df <- st_transform(sb_fhz, "+init=epsg:4326")
#using sf package allows you to transform geographic data more easily

sb_fh_class <- sb_df %>% 
  select(HAZ_CLASS)
#only going to store information for one hazarad class

# Define UI for application that draws a map
ui <- fluidPage(
   
   # Application title
   titlePanel("Santa Barbara Fire Hazard Zones"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
        selectInput("class", 
                    "Fire Hazard Class:", 
                    choices = unique(sb_fh_class$HAZ_CLASS))
        
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("fire_map")
      )
   )
)

# Define server logic required to draw an interactive map
server <- function(input, output) {
   
   output$fire_map <- renderLeaflet({
     
     fire_sub <- sb_fh_class %>% 
       filter(HAZ_CLASS == input$class)
     
     leaflet(fire_sub) %>% 
       addTiles() %>% 
       addPolygons( weight = 0.5,
                    color = "red",
                    fillColor = "orange",
                    fillOpacity = 0.5)
     
   })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

