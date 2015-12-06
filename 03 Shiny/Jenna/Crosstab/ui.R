#ui.R 

library(shiny)

navbarPage(
  title = "Number of Casualties for Road Class vs. Road Surface",
  tabPanel(title = "Fatal",
           sidebarPanel(
             #actionButton(inputId = "light", label = "Light"),
             #actionButton(inputId = "dark", label = "Dark"),
             actionButton(inputId = "clicks_fatal",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_jenna1")
           )
  ),
  tabPanel(title = "Serious",
           sidebarPanel(
             #actionButton(inputId = "light", label = "Light"),
             #actionButton(inputId = "dark", label = "Dark"),
             actionButton(inputId = "clicks_serious",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_jenna2")
           )
  ),
  tabPanel(title = "Slight",
           sidebarPanel(
             #actionButton(inputId = "light", label = "Light"),
             #actionButton(inputId = "dark", label = "Dark"),
             actionButton(inputId = "clicks_slight",  label = "Click me")
           ),
           
           mainPanel(plotOutput("distPlot_jenna3")
           )        
  )
)
