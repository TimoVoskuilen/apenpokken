##ui.R

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

# Define UI for my first breast cancer application
shinyUI(pageWithSidebar(
  
  # my Application title
  headerPanel("Monkeypox Rate across Countrys"),
  
  # a sidebar with controls to select the continent for wich I want to see the distribution
  
  sidebarPanel(
    numericInput("obs", "Choose how many countries to view in the table", 3),
    selectInput("plottie", "Choose what you want to plot", choices = c("Confirmed_Cases", "Suspected_Cases", "Hospitalized"))
    
  ),
  
  mainPanel(
    
    h4(textOutput("caption")),
    
    tableOutput("rank"),
    
    helpText("Below we report the same data of the table, on a world map. The size of the circle corresponds to the number of monkeypox new cases on that country."),
    
    plotOutput("map"),
    
    helpText("The disease is growing, and as it is still containable, this is a good way to keep an eye on spreading of the disease")
    
  )
  
))
