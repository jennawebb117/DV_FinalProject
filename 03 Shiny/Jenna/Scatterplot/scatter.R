require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

accidents_location <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select GRID_REF_EASTING, GRID_REF_NORTHING, NUMBER_OF_CASUALTIES
from Leeds_road_accidents_2013_2014;"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))


ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Location of Accidents') +
  labs(x=paste("Easting"), y=paste("Northing")) +
  layer(data=accidents_location, 
        mapping=aes(x=GRID_REF_EASTING, y=GRID_REF_NORTHING, color=NUMBER_OF_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        position=position_identity()
  )
