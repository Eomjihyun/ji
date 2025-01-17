library(tidyverse)
library(shiny)
library(ggplot2)
library(dplyr)
happy_ <- read.csv("HAPPYY.csv",fileEncoding = "UCS-2LE")

# Define UI ----

ui <- fluidPage(
  
  titlePanel("Happy score"),
  
  
  sidebarLayout(
    sidebarPanel(
      helpText("범위를 선택하면 그 범위내에서 행복지수를 가지는 구들의 행복지수를 확인할 수 있습니다. "), 
      sliderInput("range", h3("범위를 선택하세요"), min=0,max=1, value=c(0,1), step=0.1)),
    
      mainPanel(plotOutput("plott"))
    
    )

  )



server <- function( input, output ) { 

 
output$plott <- renderPlot({
  shinyhappy <- filter(happy_ ,happy_ $행복지수>=input$range[1]&happy_ $행복지수<=input$range[2])
  ggplot( data=shinyhappy, aes( x=분류, y=행복지수, fill="orange")) +
    geom_bar(stat='identity') +
    theme_bw()+
    ggtitle("Happy score") +
    theme(plot.title = element_text(size = 20, face = "bold", color = "red"))+
    theme(axis.title = element_text(size = 20, color = "black"))+
    theme(axis.text.x = element_text(size = 15, angle = 90, hjust = 1, vjust = .5, color ="black")) +
    theme(axis.text.y = element_text(size = 15, color ="black"))+
    theme(legend.position = "none")
      
      })

}

shinyApp(ui = ui, server = server)

  




