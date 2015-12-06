require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

low = 4


#####################################FATAL#####################################
accidents_fatal <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \'High\'
else \'Low\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, NUMBER_OF_CASUALTIES as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014)
where CASUALTY_SEVERITY = \\\'Fatal\\\';"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = low), verbose = TRUE)))


ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Number of Casualties for Road Surface vs. Road Class (Fatal)') +
  labs(x=paste("ROAD_CLASS"), y=paste("ROAD_SURFACE")) +
  layer(data=accidents_fatal, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="red"), 
        position=position_identity()
  ) +
  layer(data=accidents_fatal, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.20, colour = "red"), 
        position=position_identity()
  ) +
  theme(axis.text.x = element_text(angle=60, hjust=1)
  )
#####################################################################



#####################################SERIOUS#####################################
accidents_serious <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \'High\'
else \'Low\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, NUMBER_OF_CASUALTIES as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014)
where CASUALTY_SEVERITY = \\\'Serious\\\';"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = low), verbose = TRUE)))


ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Number of Casualties for Road Surface vs. Road Class (Serious)') +
  labs(x=paste("ROAD_CLASS"), y=paste("ROAD_SURFACE")) +
  layer(data=accidents_serious, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="red"), 
        position=position_identity()
  ) +
  layer(data=accidents_serious, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.20, colour = "red"), 
        position=position_identity()
  ) +
  theme(axis.text.x = element_text(angle=60, hjust=1)
  )
#####################################################################




#####################################SLIGHT#####################################
accidents_slight <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=
"select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, KPI_NUM_CASUALTIES,
case
when KPI_NUM_CASUALTIES > "p1" then \'High\'
else \'Low\'
end KPI_NUM_CASUALTIES
from (select ROAD_CLASS, ROAD_SURFACE, CASUALTY_SEVERITY, NUMBER_OF_CASUALTIES as KPI_NUM_CASUALTIES
from Leeds_road_accidents_2013_2014)
where CASUALTY_SEVERITY = \\\'Slight\\\';"')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_jnw653', PASS='orcl_jnw653', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON', p1 = low), verbose = TRUE)))


ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Number of Casualties for Road Surface vs. Road Class (Slight)') +
  labs(x=paste("ROAD_CLASS"), y=paste("ROAD_SURFACE")) +
  layer(data=accidents_slight, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, label=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="red"), 
        position=position_identity()
  ) +
  layer(data=accidents_slight, 
        mapping=aes(x=ROAD_CLASS, y=ROAD_SURFACE, fill=KPI_NUM_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.20, colour = "red"), 
        position=position_identity()
  ) +
  theme(axis.text.x = element_text(angle=60, hjust=1)
  )
#####################################################################




