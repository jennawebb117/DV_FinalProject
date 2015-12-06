# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)

shinyServer(function(input, output) {
  
  fatal_low = 11
  serious_low = 156
  slight_low = 1431

  #################Dataframe for fatal casualties#################
  
  accidents_fatal <- eventReactive(input$clicks_fatal, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \\\'High\\\'
else \\\'Low\\\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, sum(NUMBER_OF_CASUALTIES) as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014
where CASUALTY_SEVERITY = \\\'Fatal\\\'
group by ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY);"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = fatal_low), verbose = TRUE)))
  })
  

  #################Dataframe for serious casualties#################
  accidents_serious <- eventReactive(input$clicks_serious, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \'High\'
else \'Low\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, sum(NUMBER_OF_CASUALTIES) as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014
where CASUALTY_SEVERITY = \\\'Serious\\\'
group by ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY);"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = serious_low), verbose = TRUE)))
  }) 
  
  
  #################Dataframe for slight casualties#################
  accidents_slight <- eventReactive(input$clicks_slight, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \'High\'
else \'Low\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, sum(NUMBER_OF_CASUALTIES) as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014
where CASUALTY_SEVERITY = \\\'Slight\\\'
group by ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY);"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = slight_low), verbose = TRUE)))
  })  
  
  
  
  #################Plot for fatal casualties#################
  output$distPlot_jenna1 <- renderPlot({             
    plot_jenna1 <- ggplot() + 
      coord_cartesian() + 
      scale_x_discrete() +
      scale_y_discrete() +
      labs(title=isolate("Number of Casualties for Road Surface vs. Road Class (Fatal)")) +
      labs(x=paste("Road Class"), y=paste("Road Surface")) +
      layer(data=accidents_fatal(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="text",
            geom_params=list(colour="red"), 
            position=position_identity()
      ) +
      layer(data=accidents_fatal(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="tile",
            geom_params=list(alpha=0.3, colour = "#006600"), 
            position=position_identity()
      ) +
      theme(axis.text.x = element_text(angle=60, hjust=1, size = 15)
      ) +
      theme(axis.text.y = element_text(size = 15)
      )
    plot_jenna1
  }) 
  
  
  
  #################Plot for serious casualties#################
  output$distPlot_jenna2 <- renderPlot({             
    plot_jenna2 <- ggplot() + 
      coord_cartesian() + 
      scale_x_discrete() +
      scale_y_discrete() +
      labs(title=isolate("Number of Casualties for Road Surface vs. Road Class (Serious)")) +
      labs(x=paste("Road Class"), y=paste("Road Surface")) +
      layer(data=accidents_serious(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="text",
            geom_params=list(colour="red"), 
            position=position_identity()
      ) +
      layer(data=accidents_serious(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="tile",
            geom_params=list(alpha=0.3, colour = "#006600"), 
            position=position_identity()
      ) +
      theme(axis.text.x = element_text(angle=60, hjust=1, size = 15)
      ) +
      theme(axis.text.y = element_text(size = 15))
    plot_jenna2
  })   
  
  
  
  #################Plot for slight casualties#################
  output$distPlot_jenna3 <- renderPlot({             
    plot_jenna3 <- ggplot() + 
      coord_cartesian() + 
      scale_x_discrete() +
      scale_y_discrete() +
      labs(title=isolate("Number of Casualties for Road Surface vs. Road Class (Slight)")
      ) +
      labs(x=paste("Road Class"), y=paste("Road Surface")) +
      layer(data=accidents_slight(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="text",
            geom_params=list(colour="red"), 
            position=position_identity()
      ) +
      layer(data=accidents_slight(), 
            mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="tile",
            geom_params=list(alpha=0.3, colour = "#006600"), 
            position=position_identity()
      ) +
      theme(axis.text.x = element_text(angle=60, hjust=1, size = 15)
      ) +
      theme(axis.text.y = element_text(size = 15))
    plot_jenna3
  })  
})
