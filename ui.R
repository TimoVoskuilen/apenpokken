##ui.R

library(shiny)
monkeypox_data<- read.csv("data_raw/Monkey_Pox_Cases_Worldwide.csv")
monkeypox_data
# Define UI for my first breast cancer application
shinyUI(pageWithSidebar(
  
  # my Application title
  headerPanel("Monkeypox Rate across Countrys"),
  
  # a sidebar with controls to select the continent for wich I want to see the distribution
  
  sidebarPanel(
    numericInput("obs", "Choose how many countries to view in the table", 3)
    
  ),
  
  mainPanel(
    
    h4(textOutput("caption")),
    
    tableOutput("rank"),
    
    helpText("Below we report the same data of the table, on a world map. The size of the circle corresponds to the number of monkeypox new cases on that country."),
    
    plotOutput("map"),
    
    helpText("The disease is growing, and as it is still containable, this is a good way to keep an eye on spreading of the disease")
    
  )
  
))
