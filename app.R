#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(locfit)
library(knitr)
library(DT)
library(tidyverse)
library(dplyr)
data(penny) 

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sample Penny Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons("num_pennies",
                        h3("Number of pennnies to sample:"),
                        choices = list("5" = 5,
                                       "10" = 10,
                                       "25" = 25,
                                       "50" = 50)
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           tabsetPanel(
               tabPanel("pennies", tableOutput("pennyData"))
           )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
       
    selected_years <- reactive({
        penny %>%
            sample_n(size = input$num_pennies) %>%
            select(year) %>%
            arrange(year)
            
    })

    output$pennyData <- renderTable({
        selected_years()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
