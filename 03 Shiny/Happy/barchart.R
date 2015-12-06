require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)

df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, SUM(NUMBER_OF_CASUALTIES) as some
from LEEDS_ROAD_ACCIDENTS_2013_2014
                                                      ;"
                                                      ')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE))) 
View(df)

dfFemale <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select AGE_OF_CASUALTY, CASUALTY_CLASS, SUM_NUMBER_OF_CASUALTIES, sum(SUM_NUMBER_OF_CASUALTIES)  
OVER(PARTITION BY CASUALTY_CLASS) as window_avg_count
from 
(select AGE_OF_CASUALTY, CASUALTY_CLASS, sum(NUMBER_OF_CASUALTIES) as SUM_NUMBER_OF_CASUALTIES
from LEEDS_ROAD_ACCIDENTS_2013_2014
where ( CASUALTY_CLASS=(\'Driver or rider\') and SEX_OF_CASUALTY=(\'Male\') OR SEX_OF_CASUALTY=(\'Female\') )
group by AGE_OF_CASUALTY, CASUALTY_CLASS)
order by CASUALTY_CLASS;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

dfchl <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query=                                          
"select YEAR, DISEASE, sum_COUNT, sum(sum_COUNT)                                OVER (PARTITION BY DISEASE) as window_avg_COUNT
from 
(select YEAR, DISEASE, sum(COUNT) as sum_COUNT
from Infectious_Diseases
where DISEASE = (\'Chlamydia\') and (SEX=(\'Male\') OR SEX=(\'Female\') )
group by YEAR, DISEASE)
order by DISEASE;"
')), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_hys82', PASS='orcl_hys82', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
