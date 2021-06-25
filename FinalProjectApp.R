library(ggplot2)
library(tidyverse)
library(tidyr)
library(dplyr)
library(plyr)
library(shiny)
library(leaflet)
library(hrbrthemes)

performances <- read_csv("performances.csv")
performances

ladies_free <- performances %>% 
  select(everything()) %>%
  filter(program == "LADIES FREE SKATING") %>%
  arrange(nation, name)
ladies_free

ui <- fluidPage(
  titlePanel("Country's Competitors"),
  sidebarLayout(
    sidebarPanel(
      p("Use the dropdown menu to view the stats on each country's competitor"),
      selectInput(
        inputId = "nation",
        label = "Select the competitors country",
        choices = c("ARM", "AUS", "AUT", "BEL", "CAN", "CHN", "CZE", "EST", "FIN", "FRA", "GBR", "GER", "HKG", "HUN", "ITA", "JPN", "KAZ", "KOR", "LAT", "NOR", "RUS", "SGP", "SVK", "SWE", "TPE", "UKR", "USA"),
        multiple = TRUE
      )
    ),
    mainPanel(
      p("Using the selection box, you can sort through the competitors results by country, and learn more about the competitors for each country. The original dataset was taken from ",
        a("Buzzfeed News.", href = "https://github.com/BuzzFeedNews/figure-skating-scores")),
      dataTableOutput(outputId = "ladies_free")
    )
  ))

server <- function(input, output) {
  output$ladies_free <- renderDataTable({dplyr::filter(
    ladies_free, nation %in% input$nation)
  })
  
}

shinyApp(ui = ui, server = server)
