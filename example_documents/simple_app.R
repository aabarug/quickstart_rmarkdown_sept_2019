library(shiny)
library(tidyverse)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
    # Input: Slider for the number of bins ----
    selectInput(inputId = "select_airline", label = h3("Select airlines"), 
                choices = list("Jetstar", "Qantas", "Virgin Australia"), 
                selected = "Jetstar"),
    # Output: Histogram ----
    plotOutput(outputId = "linePlot")
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
    output$linePlot <- renderPlot({
        
        df <- read_csv("data/df2_airline_subset.csv") %>% 
            filter(Airline == input$select_airline)
        
        ggplot(df, aes(x = Month, y = Arrivals_On_Time, 
                       group = Airline)) + geom_line()
        
    })
}

shinyApp(ui = ui, server = server)