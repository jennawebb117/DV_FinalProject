# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)

shinyServer(function(input, output) {
  
  Number_of_Casualties <- reactive({input$num_casualties}) 
  
  accidents_location <- eventReactive(input$clicks_location, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
                                                                                                        "select NUMBER_OF_CASUALTIES, GRID_REF_EASTING, GRID_REF_NORTHING from Leeds_road_accidents_2013_2014;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_cmm5627', PASS='orcl_cmm5627', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1=Number_of_Casualties()), verbose = TRUE)))
  })
  
  
  output$distPlot_jenna4 <- renderPlot({             
    plot_jenna4 <- ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title=isolate("Location of Accidents")) +
      labs(x=paste("Easting"), y=paste("Northing")) +
      layer(data=accidents_location(), 
            mapping=aes(x=GRID_REF_EASTING, y=GRID_REF_NORTHING, color=NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list(), 
            position=position_identity()
      ) 
    plot_jenna4
  }) 
  
  })
