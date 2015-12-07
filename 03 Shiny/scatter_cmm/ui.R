#ui.R 

library(shiny)

navbarPage(
  title = "Location of Accidents",
  tabPanel(title = "Map",
           sidebarPanel(
             numericInput("num_casualties", "Number_of_Casualties:", value = 0),
             actionButton(inputId = "clicks_location",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_jenna4")
           )
  )
)
