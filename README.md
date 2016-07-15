# Crimes_Visualization

This project visualizes crimes, such as stealing, burglaries, auto thefts and robberies across Greece in the first semester of 2010. The data used for this project are open data available at the Geodata website (http://geodata.gov.gr/dataset/anoikhta-demosia-dedomena-egklematikotetas). The dataset contains plenty of different crimes conducted, categorized per Police Headquarters, month and crime type. These data were transformed properly and visualized on plots and maps as useful information.

The open source tool we used for the analysis, is the R Studio which supports R programming language. Using R we transformed the data, created the proper maps and constructed an application which is available on the Shinyapps platform at the following link:
https://maybach.shinyapps.io/Crimes_Visualization/

Next, we moved the whole application files, e.g. R scripts, shapefiles etc. to Github repository, available at the following link:
https://github.com/Maybach1988/Crimes_Visualization 

Regarding the analysis, we extracted the data from the website and transformed them properly. The transformation included column selection, e.g. we investigated the total number of crimes either they were solved or not. Then, we aggregated the crimes per month and geographic region. Each crime type (they are three in total) may be split into subtypes. So, the new tables included the total number of crimes per area, month and type, split per subtype.

Additionally, we had to transform the shapefiles (the geometric representation of a geographical area), so as to match their geographic regions’ representation with the data’s. Only then we are able to visualize different crime numbers on the map. Each map visualizes the number of crimes per region for a specific month and crime type. Selecting a specific region, we may drill down to the crime subtypes levels and understand how crime numbers differ per subtype.

Now, having transformed the data properly, we proceeded with the application construction. In order to create a shiny app, we had to define three files, “ui.R”, “visualization.R” and “global.R”. In the global file, we define where are the data stored. Next, in ui file, we define the panels that are shown to the final users. In order to visualize the data, we use a title panel (with the title), a side panel (with the selection criteria and the subtypes plot) and the main panel that shows the map. Last but not least, the visualization file contains all the script that matches the data with the shapefiles and creates the plots.

So, if we open the shiny application (https://maybach.shinyapps.io/Crimes_Visualization/) we see the left side panel, as well as instructions on how to create the desired map. First, we select the month (January to June) that we want to examine and next we select the crime category. After a few seconds the map shows up, which represents the number of crimes conducted across different geographic regions. If we select a region on the map, we may see the name of the region. Next, if we move back to the left panel and select a region, then we drill down to the subtype level and see the distribution of crimes (for the selected crime type) among different crime subtypes.

All in all, the application is publicly available and provides a quick review of crime distribution in the Greek area. Combining facts with geographical data leads to well understood visualization that may support researches and crime studies, without the obstacle of may facts and numbers.
