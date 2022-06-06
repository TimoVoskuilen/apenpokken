## server.R

library(shiny)
library(maps)
library(dplyr)
library(neattools)

# Source my monkeypox file with data
monkeypox_data<- read.csv("data_raw/Monkey_Pox_Cases_Worldwide.csv")
names(monkeypox_data)[names(monkeypox_data)=="Country"]<-"country"
monkeypox_data<-replacevalue(monkeypox_data, "country", "England", "United Kingdom")
monkeypox_data
# source of country latitude and longtitude 
countryCoordinates <- read.csv("data_raw/world_country_and_usa_states_latitude_and_longitude_values.csv")
countryCoordinates2 <- countryCoordinates[,c(2,3,4)]
countryCoordinates2
# Create a smaller data frame including only my variables of #interest:country, monkeypox rate, continent
x<- monkeypox_data[,c(1,2,3,4)]

mergedCleaned <- merge(monkeypox_data, countryCoordinates2, by="country", all.x=FALSE)
mergedCleaned


# Define server logic to plot monkeypox data for various #continents/countries
shinyServer(function(input,output){
  
  # Sentence presenting the table in a reactive expression
  tableText<- reactive({
    paste("This table ranks countries by number of monkeypox cases. You have selected all countries in")
  })
  
  # now I return the tabletText for printing as a caption
  output$caption<- renderText({
    tableText()
  })
  
  
  # Plot a table that ranks countries (from most affected to the least) by monkeypox rate
  output$rank<- renderTable({
    head(x[order(x$Confirmed_Cases, decreasing=T),], n = input$obs)  
      
  })
  
  # Plot a world map visualizing monkeypox incidence. The radius of the circle correspond
  # to the number of monkeypox new cases (larger radius = more monkeypox new cases)
  
  
  output$map<- renderPlot({
    
    map("world",col="gray90", fill=TRUE)
    radius <- (mergedCleaned[,input$plottie])
    symbols(mergedCleaned$longitude, mergedCleaned$latitude, bg = "red", fg = "green", lwd = 0.1, circles = radius, inches = 0.12, add = TRUE)
  
  })
  
  
  
})