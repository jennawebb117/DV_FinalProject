#ui.R 

library(shiny)

navbarPage(
  title = "Final Project",
  tabPanel(title = "Barchartpanel",
           sidebarPanel(
             actionButton(inputId = "clicks_MALE",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_happy"))
                     
           

)
)
