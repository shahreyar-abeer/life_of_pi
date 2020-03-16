

library(shiny)
library(bootstraplib)

ui = navbarPage(
  title = "Estimating pi",
  
  tabPanel(
    title = "Home",
    
    sidebarLayout(
      sidebarPanel(
        numericInput("n", "n", value = 100, min = 100, max = 100000, step = 100)
      ),
      
      mainPanel(
        imageOutput("anim1", width = "1000px", height = "800px")
      )
    )
    
    
  )
)