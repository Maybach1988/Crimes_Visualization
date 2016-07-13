server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  
  
  
  
  
  
  output$mymap <- renderLeaflet({
    
    if(input$months == "January") {
      gr <- gr_january
    }
    if(input$months == "February") {
      gr <- gr_february
    }
    if(input$months == "March") {
      gr <- gr_march
    }
    if(input$months == "April") {
      gr <- gr_april
    }
    if(input$months == "May") {
      gr <- gr_may
    }
    if(input$months == "June") {
      gr <- gr_june
    }
    
    
   if (input$categories == "Steal_Burglary") {
    x <- gr@data$Stl_Brg
   }
    if (input$categories == "Robberies") {
      x<- gr@data$Robbers
    } else x <- gr@data$Atmtv_s
     
    pal <- colorNumeric(palette = "Reds",domain = x)
    
    leaflet(gr) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(x),
                  fillOpacity = 0.8,
                  color = "#BDBDC3",
                  weight = 1, popup = ~NAME_2)
   
    
  })
  
  output$trendPlot <- renderPlotly({
    # size of the bins depend on the input 'bins'
    #size <- (maxx - minx) / input$bins
    if(input$months == "January") {
      plot_month <- plot_january
    }
    if(input$months == "February") {
      plot_month <- plot_february
    }
    if(input$months == "March") {
      plot_month <- plot_march
    }
    if(input$months == "April") {
      plot_month <- plot_april
    }
    if(input$months == "May") {
      plot_month <- plot_may
    }
    if(input$months == "June") {
      plot_month <- plot_june
    }
    
    
    if (input$categories == "Steal_Burglary") {
      y <- 2:9
    }
    if (input$categories == "Automotive_stealing") {
      y <- 11:15
    } else y <- 17:27
    
    gg <- ggplot(plot_month[plot_month$Area==input$regions,][y,],aes(x=variable,y=value,fill = variable)) + 
      geom_bar(stat = "identity")  + theme(axis.text.x = element_blank())
    
    # Convert the ggplot to a plotly
    p <- ggplotly(gg)
    p
    
    
      
  
     
  })
  
  
}