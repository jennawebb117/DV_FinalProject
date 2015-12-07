# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)

shinyServer(function(input, output) {
  
accidents_location <- eventReactive(input$clicks_location, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select GRID_REF_EASTING, GRID_REF_NORTHING, NUMBER_OF_CASUALTIES
                                                                                                        from Leeds_road_accidents_2013_2014;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
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
  
ALLSEX <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
 OVER() as TOTAL_CASUALTIES
from 
(select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
from LEEDS_ROAD_ACCIDENTS_2013_2014
where (SEX_OF_CASUALTY=(\'Male\') OR SEX_OF_CASUALTY=(\'Female\') )
group by AGE_OF_CASUALTY)
order by AGE_OF_CASUALTY desc;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 
  
MALE <- eventReactive(input$clicks_MALE, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
OVER() TOTAL_CASUALTIES                                                         from 
(select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
from LEEDS_ROAD_ACCIDENTS_2013_2014
where (SEX_OF_CASUALTY=(\'Male\'))
group by AGE_OF_CASUALTY)
order by AGE_OF_CASUALTY desc;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  })
  
  
  output$distPlot_happy <- renderPlot({             
    plot_happy <- ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='NUMBER OF CASUALTIES BY AGE') +
      labs(x=paste("AGE"), y=paste("NUMBER OF CASUALTIES")) +
      layer(data=ALLSEX, 
            mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="bar",
            geom_params=list(fill="RED"), 
            position=position_identity()
      ) + coord_flip() +
      layer(data=MALE(), 
            mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="bar",
            geom_params=list(fill="#339933"), 
            position=position_identity()
      ) + coord_flip() +
      layer(data=ALLSEX, 
            mapping=aes(yintercept = 8829/95), 
            geom="hline",
            geom_params=list(colour="BLACK")
      ) +
      layer(data=ALLSEX, 
            mapping=aes(x=0, y=round(8829/95), label=round(8829/95)), 
            stat="identity", 
            stat_params=list(), 
            geom="text",
            geom_params=list(colour="black", hjust=-.2), 
            position=position_identity()
      ) 
    plot_happy
  }) 
  FATAL <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
                                                     OVER() as TOTAL_CASUALTIES
                                                     from 
                                                     (select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
                                                     from LEEDS_ROAD_ACCIDENTS_2013_2014
                                                     where (CASUALTY_SEVERITY=(\'Fatal\') OR CASUALTY_SEVERITY=(\'Serious\') OR CASUALTY_SEVERITY=(\'Slight\') )
                                                     group by AGE_OF_CASUALTY)
                                                     order by AGE_OF_CASUALTY desc;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 
  
  SERIOUS <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
                                                       "select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
                                                       OVER() as TOTAL_CASUALTIES
                                                       from 
                                                       (select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
                                                       from LEEDS_ROAD_ACCIDENTS_2013_2014
                                                       where (CASUALTY_SEVERITY=(\'Serious\') OR CASUALTY_SEVERITY=(\'Slight\') )
                                                       group by AGE_OF_CASUALTY)
                                                       order by AGE_OF_CASUALTY desc;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 
  
  SLIGHT <- eventReactive(input$clicks_severity, {data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
                                                                                            "select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
                                                                                            OVER() as TOTAL_CASUALTIES
                                                                                            from 
                                                                                            (select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
                                                                                            from LEEDS_ROAD_ACCIDENTS_2013_2014
                                                                                            where (CASUALTY_SEVERITY=(\'Slight\') )
                                                                                            group by AGE_OF_CASUALTY)
                                                                                            order by AGE_OF_CASUALTY desc;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  })
  
  
  output$distPlot_happy2 <- renderPlot({             
    plot_happy2 <- ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='NUMBER OF CASUALTIES BY AGE') +
      labs(x=paste("AGE"), y=paste("NUMBER OF CASUALTIES")) +
      layer(data=FATAL, 
            mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="bar",
            geom_params=list(fill="BLUE"), 
            position=position_identity()
      ) + coord_flip() +
      layer(data=SERIOUS, 
            mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="bar",
            geom_params=list(fill="RED"), 
            position=position_identity()
      ) + coord_flip() +
      layer(data=SLIGHT(), 
            mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
            stat="identity", 
            stat_params=list(), 
            geom="bar",
            geom_params=list(fill="#339933"), 
            position=position_identity()
      ) + coord_flip() +
      layer(data=FATAL, 
            mapping=aes(yintercept = 8829/95), 
            geom="hline",
            geom_params=list(colour="BLACK")
      ) +
      layer(data=FATAL, 
            mapping=aes(x=0, y=round(8829/95), label=round(8829/95)), 
            stat="identity", 
            stat_params=list(), 
            geom="text",
            geom_params=list(colour="black", hjust=-.2), 
            position=position_identity()
      ) 
    plot_happy2
  }) 
  
  
  
  })

