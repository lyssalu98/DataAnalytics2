library(ggplot2)
library(tidyverse)
library(tidyr)
library(dplyr)
library(plyr)
library(shiny)
library(leaflet)
library(hrbrthemes)

osmond <- performances %>%
  select(everything()) %>%
  filter(name == "Kaetlyn OSMOND")

ui <- fluidPage(
  titlePanel("Kaetlyn Osmond's Competition Results"),
  sidebarLayout(
    sidebarPanel(
      p("Use the dropdown menu to view the Kaetlyn's results from each competition"),
      selectInput(
        inputId = "competition",
        label = "Select the competition",
        choices = c("Grand Prix Final 2017 Senior and Junior", "ISU Four Continents Championships 2017", "ISU GP 2016 Skate Canada International", "ISU GP 2017 Skate Canada International", "ISU GP Audi Cup of China 2016", "ISU GP Internationaux de France de Patinage 2017", "ISU Grand Prix of Figure Skating Final 2016", "ISU World Figure Skating Championships 2017"),
        multiple = TRUE
      )
    ),
    mainPanel(
      p("Using the selection box, you can learn more about Kaetlyn's results from each of her competitions"),
      dataTableOutput(outputId = "osmond")
    )
  ))

server <- function(input, output) {
  output$osmond <- renderDataTable({dplyr::filter(
    osmond, competition %in% input$competition)
  })
  
}

shinyApp(ui = ui, server = server)