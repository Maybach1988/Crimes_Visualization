
shinyUI(fluidPage(
  titlePanel("Crimes in 2010"),
  sidebarPanel(
    
    h2("Data Explanation"),
    p("These data concern crimes occured during the 1st half of 2010 in Greece. Data are divided in 3 major categories for each Region as it can be seen in the map."),
    p("More information about the dataset can be found ",
      a("here.", 
        href = "http://geodata.gov.gr/dataset/anoikhta-demosia-dedomena-egklematikotetas")),
    br(),
    
  
    selectInput("months","Select Month",c("January","February","March","April","May","June")),
    #tags$div(class="header", checked=NA,
    #         tags$p("By selecting Category and Region you can customize the output of the plot below!")
             
    #),
    br(),
    p("After deciding the month, user can choose one of the major categories and how Regions are affected."),
    br(),
    br(),
    selectInput("categories", "Select Category",c("Steal_Burglary","Automotive_stealing","Robberies")),
    br(),
    p("By choosing a specific region the user can drill down the category chosen above to get more details."),
    br(),
    selectInput("regions", "Select Region", c("North Aegean","South Aegean","Central Macedonia","Central Greece","Crete","Epirus","West Macedonia","East Macedonia and Thrace","Ionian Islands","Peloponnese","West Greece","Thessaly")),
    plotlyOutput("trendPlot")
    
    
  ),
  mainPanel(
    leafletOutput("mymap",height = "800px")
    
  )
))