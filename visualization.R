##########libraries needed for project#############
library(maptools)
library(leaflet)
library(reshape2)
library(ggplot2)
library(rgdal)


###########reading the correct shape containing the polygons we need##################
gr <- readShapeSpatial("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/shapefiles greece/GRC_adm2.shp")

####look at the data inside the shape file####
head(gr@data)  ##we need the NAME_2 variable for plotting later


######example to see how it looks like in a map############
greece <-c(geom_polygon(aes(long,lat,group=group), size = 0.1, colour= "#090D2A",
                        fill="#090D2A", alpha=0.4, data=gr))

ggplot() + greece


###########small change in the shape file, changing the NAME_2 of two observations so as not to have a conflict with our data later#############
gr@data$NAME_2 <- ifelse (gr@data$NAME_2 == "Athos", "Central Macedonia",as.character(gr@data$NAME_2))
gr@data$NAME_2 <- ifelse (gr@data$NAME_2 == "Attica", "Central Greece",as.character(gr@data$NAME_2))


########loading the data concerning the crimes during 2010#########
January_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/January_2010.txt")
February_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/February_2010.txt")
March_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/March_2010.txt")
April_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/April_2010.txt")
May_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/May_2010.txt")
June_2010 <- read.delim("C:/Users/nick.papakonsta/Downloads/Spinellis/Spinellis/Assignment 6/June_2010.txt")


#########look of the data##########
head(January_2010)




# january$Area <- ifelse(january$Area == "ΑΝ. ΜΑΚΕΔΟΝΙΑΣ & ΘΡΑΚΗΣ","East Macedonia and Thrace",january$Area)
# january$Area <- ifelse(january$Area == "ΒΟΡΕΙΟΥ ΑΙΓΑΙΟΥ","North Aegean",january$Area)
# january$Area <- ifelse(january$Area == "ΔΥΤΙΚΗΣ ΕΛΛΑΔΑΣ","West Greece",january$Area)
# january$Area <- ifelse(january$Area == "ΔΥΤΙΚΗΣ ΜΑΚΕΔΟΝΙΑΣ","West Macedonia",january$Area)
# january$Area <- ifelse(january$Area == "ΗΠΕΙΡΟΥ","Epirus",january$Area)
# january$Area <- ifelse(january$Area == "ΘΕΣΣΑΛΙΑΣ","Thessaly",january$Area)
# january$Area <- ifelse(january$Area == "ΙΟΝΙΩΝ ΝΗΣΩΝ","Ionian Islands",january$Area)
# january$Area <- ifelse(january$Area == "ΚΕΝΤΡΙΚΗΣ ΜΑΚΕΔΟΝΙΑΣ","Central Macedonia",january$Area)
# january$Area <- ifelse(january$Area == "ΚΡΗΤΗΣ","Crete",january$Area)
# january$Area <- ifelse(january$Area == "ΝΟΤΙΟΥ ΑΙΓΑΙΟΥ","South Aegean",january$Area)
# january$Area <- ifelse(january$Area == "ΠΕΛΟΠΟΝΝΗΣΟΥ","Peloponnese",january$Area)
# january$Area <- ifelse(january$Area == "ΣΤΕΡΕΑΣ ΕΛΛΑΔΑΣ","Central Greece",january$Area)


###############create a new shape file for each month, where each file contains the data concerning this month#################
gr_january <- gr
gr_january@data <- cbind(gr_january@data,January_2010[,-1])    #exclude first column containing the names

gr_february <- gr
gr_february@data <- cbind(gr_february@data,February_2010[,-1])

gr_march <- gr
gr_march@data <- cbind(gr_march@data,March_2010[,-1])

gr_april <- gr
gr_april@data <- cbind(gr_april@data,April_2010[,-1])

gr_may <- gr
gr_may@data <- cbind(gr_may@data,May_2010[,-1])

gr_june <- gr
gr_june@data <- cbind(gr_june@data,June_2010[,-1])


###############create the leaflet map for a specific type of crime#################
pal <- colorNumeric(palette = "Reds",domain = gr_january@data$Steal_Burglary)

leaflet(gr_january) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(fillColor = ~pal(Steal_Burglary),
              fillOpacity = 0.8,
              color = "#BDBDC3",
              weight = 1, popup = ~NAME_2)


############create the dataframes in a suitable form for creating the bar ggplots############
plot_january <- melt(January_2010)
plot_february <- melt(February_2010)
plot_march <- melt(March_2010)
plot_april <- melt(April_2010)
plot_may <- melt(May_2010)
plot_june <- melt(June_2010)

ggplot(plot_january[plot_january$Area=="North Aegean",][2:9,],aes(x=variable,y=value,fill = variable)) + geom_bar(stat = "identity") + theme(axis.text.x = element_blank())
ggplot(plot_january[plot_january$Area=="North Aegean",][11:15,],aes(x=variable,y=value,fill = variable)) + geom_bar(stat = "identity")
ggplot(plot_january[plot_january$Area=="North Aegean",][17:27,],aes(x=variable,y=value,fill = variable)) + geom_bar(stat = "identity")



###########save the plot dataframes in order for usage inside shiny##################
write.table(plot_january,"plot_january.txt")
write.table(plot_february,"plot_february.txt")
write.table(plot_march,"plot_march.txt")
write.table(plot_april,"plot_april.txt")
write.table(plot_may,"plot_may.txt")
write.table(plot_june,"plot_june.txt")

###############write the new-changed shape files again in order to be available in shiny##################
writeOGR(gr_january,dsn = ".",layer = "gr_january",driver = "ESRI Shapefile")
writeOGR(gr_february,dsn = ".",layer = "gr_february",driver = "ESRI Shapefile")
writeOGR(gr_march,dsn = ".",layer = "gr_march",driver = "ESRI Shapefile")
writeOGR(gr_april,dsn = ".",layer = "gr_april",driver = "ESRI Shapefile")
writeOGR(gr_may,dsn = ".",layer = "gr_may",driver = "ESRI Shapefile")
writeOGR(gr_june,dsn = ".",layer = "gr_june",driver = "ESRI Shapefile")
