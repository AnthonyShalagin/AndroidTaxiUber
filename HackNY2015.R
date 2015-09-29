


#parse a csv file and parse into mongodb database, pickup dropup time, long and latitude, droup lati and long, fareamount, extra, mtptax, tolls amount.

##Mongo Export

#########################################################################################
##                          Cleaning the Motor and Collisions Dataset                 ##                        ##
#########################################################################################

### Loading libraries
library(dplyr)
library(ggplot2)

### Setting the work directory
setwd("C:/Users/gascenciostudent/Desktop/HackNY")
data_dir <- "."

### Reading the collisions dataset
yellow_taxis <- data.frame(read.csv("C:/Users/gascenciostudent/Desktop/yellow_tripdata_2015-01-06.csv", nrows=1000000), 
                                             stringsAsFactors = F, sep=',', header=F)

### Extracting the columns we need
taxis <- yellow_taxis[ ,c(6, 7, 10, 11, 13, 14, 15, 17)]

### Checking if there's bad data in our dataframe
is.na(yellow_taxis$pickup_latitude && yellow_taxis$pickup_longitude && yellow_taxis$dropoff_longitude && yellow_taxis$pickup_latitude) #False = good ;)
is.na(yellow_taxis$pickup_latitude || yellow_taxis$pickup_longitude || yellow_taxis$dropoff_longitude || yellow_taxis$pickup_latitude) #False = good ;)



###########################################################################################
##                                      Data Cleaning                                    ##
###########################################################################################

### Save the file
save(taxis, file="taxi.RData")

### Convert a .RData file into a csv file
# load("taxi.RData")
# ls()
# write.csv(taxi.RData,
#           file="taxi.csv")


resave <- function(file){
  e <- new.env(parent = emptyenv())
  load(file, envir = e)
  objs <- ls(envir = e, all.names = TRUE)
  for(obj in objs) {
    .x <- get(obj, envir =e)
    message(sprintf('Saving %s as %s.csv', obj,obj) )
    write.csv(.x, file = paste0(obj, '.csv'))
  }
}

resave('taxi.RData')

#####################################################################################################

nyc_map <- create_city_basemap("New York, NY", -74.00, 40.71)
nyc_school_map_white <- ggmap(nyc_map) + geom_polygon(aes(x=long, y=lat, group=group, fill= `% White`), 
                                                      size=.2, color="black", 
                                                      data=elementary_ps, alpha=.8) + ggtitle("White") +
  scale_fill_continuous(low="red", high="blue", guide = guide_legend(title = "Percentile"))
#display math test distribution map
nyc_school_map_white
