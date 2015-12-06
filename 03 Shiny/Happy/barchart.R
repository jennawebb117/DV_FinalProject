require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

dfALLSEX <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
OVER() as TOTAL_CASUALTIES
from 
(select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
from LEEDS_ROAD_ACCIDENTS_2013_2014
where (SEX_OF_CASUALTY=(\'Male\') OR SEX_OF_CASUALTY=(\'Female\') )
group by AGE_OF_CASUALTY)
order by AGE_OF_CASUALTY desc;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 


dfMALE <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)
OVER() TOTAL_CASUALTIES
from 
(select AGE_OF_CASUALTY, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
from LEEDS_ROAD_ACCIDENTS_2013_2014
where (SEX_OF_CASUALTY=(\'Male\'))
group by AGE_OF_CASUALTY)
order by AGE_OF_CASUALTY desc;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='NUMBER OF CASUALTIES BY AGE') +
  labs(x=paste("AGE"), y=paste("NUMBER OF CASUALTIES")) +
  layer(data=dfALLSEX, 
        mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(fill="RED"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=dfMALE, 
        mapping=aes(x=AGE_OF_CASUALTY, y=SUM_NUMBER_OF_CASUALTIES), 
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        geom_params=list(fill="#339933"), 
        position=position_identity()
  ) + coord_flip() +
  layer(data=df, 
        mapping=aes(yintercept = 8829/95), 
        geom="hline",
        geom_params=list(colour="BLACK")
  ) +
  layer(data=df, 
        mapping=aes(x=0, y=round(8829/95), label=round(8829/95)), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black", hjust=-.2), 
        position=position_identity()
  )
