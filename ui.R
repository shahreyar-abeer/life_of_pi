

library(shiny)
library(bootstraplib)

bs_theme_new(bootswatch = "slate")

shinyOptions(plot.autocolors = TRUE)

ui = navbarPage(
  title = "Life of Pi: A Monte Carlo Simulation",
  
  tabPanel(
    
    bootstrap(),
    
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