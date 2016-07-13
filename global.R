library(shiny)
library(leaflet)
library(RColorBrewer)
library(maptools)
library(rgeos)
library(rgdal)
library(plotly)
library(ggplot2)


plot_january <- read.table("plot_january.txt")
plot_february <- read.table("plot_february.txt")
plot_march <- read.table("plot_march.txt")
plot_april <- read.table("plot_april.txt")
plot_may <- read.table("plot_may.txt")
plot_june <- read.table("plot_june.txt")



gr_january <- readShapeSpatial("gr_january.shp")
gr_february <- readShapeSpatial("gr_february.shp")
gr_march <- readShapeSpatial("gr_march.shp")
gr_april <- readShapeSpatial("gr_april.shp")
gr_may <- readShapeSpatial("gr_may.shp")
gr_june <- readShapeSpatial("gr_june.shp")