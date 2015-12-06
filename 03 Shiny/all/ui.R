#ui.R 

library(shiny)

navbarPage(
  title = "Final Project",

  tabPanel(title = "Scatterplot",
  sidebarPanel(actionButton(inputId = "clicks_location",  label = "Click me")),
  mainPanel(plotOutput("distPlot_jenna4"))),
  
  tabPanel(title = "Crosstab Fatal",
  sidebarPanel(actionButton(inputId = "clicks_fatal",  label = "Click me")),
  mainPanel(plotOutput("distPlot_jenna1"))),
  
  tabPanel(title = "Crosstab Serious",
  sidebarPanel(actionButton(inputId = "clicks_serious",  label = "Click me")),
  mainPanel(plotOutput("distPlot_jenna2"))),
  
  tabPanel(title = "Crosstab Slight",
  sidebarPanel(actionButton(inputId = "clicks_slight",  label = "Click me")),
  mainPanel(plotOutput("distPlot_jenna3"))), 
  
  tabPanel(title = "Barchart",
  sidebarPanel(actionButton(inputId = "clicks_MALE",  label = "Click me")),
  mainPanel(plotOutput("distPlot_happy")))
)
