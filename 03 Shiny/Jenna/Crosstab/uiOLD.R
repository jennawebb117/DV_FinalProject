#ui.R 

library(shiny)

navbarPage(
  title = "Final Project",
  tabPanel(title = "Crosstab",
      sidebarPanel(
      actionButton(inputId = "light", label = "Light"),
      actionButton(inputId = "dark", label = "Dark"),
      actionButton(inputId = "clicks_fatal", label = "Click for Fatal"),
      actionButton(inputId = "clicks_serious", label = "Click for Serious"),
      actionButton(inputId = "clicks_slight", label = "Click for Slight")
           )),
           
           mainPanel(plotOutput("distPlot_jenna1"),
           mainPanel(plotOutput("distPlot_jenna2"),
           mainPanel(plotOutput("distPlot_jenna3"))
           )
           )
  )       


