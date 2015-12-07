#ui.R 

library(shiny)

navbarPage(
  title = "Final Project",
  tabPanel(title = "Barchart by Severity",
  sidebarPanel(actionButton(inputId = "clicks_severity",  label = "Click me")),
  mainPanel(plotOutput("distPlot_happy2")))
)
