

library(shiny)
library(bootstraplib)
library(waiter)

bs_theme_new(version = "4+3", bootswatch = "slate")

#bs_theme_add_variables(black = "#E7553C")

bs_theme_accent_colors(secondary = "#447099")

shinyOptions(plot.autotheme = TRUE)

ui = navbarPage(
  title = "Life of Pi: A Monte Carlo Simulation",
  
  tabPanel(
    
    bootstrap(),
    use_waitress(),
    #shinyWidgets::useBs4Dash(),
    
    title = "Home",
    
    sidebarLayout(
      sidebarPanel(
        width = 3,
        numericInput("n", "n", value = 100, min = 100, max = 100000, step = 100),
        actionButton("run", "Eureka!")
      ),
      
      mainPanel(
        width = 9,
        fluidRow(
          column(
            width = 6,
            imageOutput("anim1", width = "700px", height = "600px")
          ),
          column(
            width = 6,
            imageOutput("anim2")
          )
        )
        
      )
    )
    
    
  )
)