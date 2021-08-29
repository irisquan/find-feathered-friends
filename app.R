#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#

library(shiny)
library(leaflet)
library(naturecounts)
source("mapfunction.R")

# Define UI ----
ui <- fluidPage(
    
    titlePanel("Find Feathered Friends", windowTitle = "Find Feather Friends"),
    
    sidebarLayout(sidebarPanel (
                      helpText ("Enter factors to be adjusted"),
                      numericInput("species", h4("Species #"), value = 136400),
                      textInput("location", h4("State/Province"), value = "AB"),
                      dateRangeInput("dates", h4("Date Range"), start = "2000-01-01", end = "2002-12-31"),
                      actionButton("refresh", "Refresh")),
                  
                  mainPanel(
                      leafletOutput("map")))
)

# Define server logic ----
server <- function(input, output, session) {
    
    # Get information about specific species
    
    # Generate map
    output$map <- renderLeaflet({
        map_maker(13640, 2000, 2002, list("ON"))
    })
}

# Run the app ----sea
shinyApp(ui = ui, server = server)