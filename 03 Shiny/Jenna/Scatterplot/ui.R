#ui.R 

library(shiny)

navbarPage(
  title = "Location of Accidents",
  tabPanel(title = "Map",
           sidebarPanel(
             #sliderInput("num_casualties", "Number of Casualties:", 
                         #min = 0, max = 10,  value = 5),
             actionButton(inputId = "clicks_location",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_jenna4")
           )
  )
)
