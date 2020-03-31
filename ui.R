

library(shiny)
library(bootstraplib)
library(waiter)
library(bsplus)
library(shinyjs)

bs_theme_new(version = "4+3", bootswatch = "slate")


bs_theme_accent_colors(secondary = "#f8f8f8e6")
bs_theme_add_variables(black = "#88837d")


ui = tagList(
  
  ## functions required to be used in the ui
  bootstrap(),
  use_waitress(),
  use_bs_popover(),
  useShinyjs(),
  withMathJax(),
  
  tags$footer(
    
    fluidRow(
      column(
        width = 4
      ),
      
      column(
        width = 8,
        tagList(
          column(width = 2),
          tags$img(src = "RStudio-Logo-White.png", width = "80px", height = "30px"),
          tags$img(src = "pipe.png", width = "60px", height = "67px"),
          tags$img(src = "shiny.png", width = "60px", height = "67px"),
          tags$img(src = "tidyverse.png", width = "60px", height = "67px"),
          tags$img(src = "gganimate.png", width = "60px", height = "67px"),
          tags$img(src = "life_of_pi_hex.png", width = "60px", height = "67px"),
          tags$img(src = "waiter.png", width = "60px", height = "67px"),
          tags$img(src = "ggforce.png", width = "60px", height = "67px")
        )
      )
    ),
    #align = "center",
    style = "position:absolute; bottom:0; width:95%;
    height:77px; /* Height of the footer */
    color: white; padding: 10px;
    background-color: #272b30; z-index: 1000;"
  ),
  
  ## color of the action button
  tags$head(
    tags$style(HTML("#run{color:#272727; height: 47px}
                     #n{height: 42px}"))
  ),
  
  ## the actual page starts here!
  navbarPage(
    
    id = "navbar",
    windowTitle = "Shiny app: Life of Pi",
    
    ## title pane
    title = tagList(
      fluidRow(
        div(
          tags$img(src = "ba.png", width = "32px", height = "26px"), HTML("&nbsp;"),
          "Life of Pi: A Monte Carlo Simulation", HTML("&nbsp;"), style = "color:#aaa;"
        ),
        div("BY ZAUAD SHAHREER ABEER", HTML("&nbsp;"),
            tags$a(href = "https://github.com/shahreyar-abeer", tags$img(src = "GitHub-Mark-Light-120px-plus.png", width = "26px", height = "26px")),
            tags$a(href = "https://www.linkedin.com/in/zauad-shahreer/", tags$img(src = "LI-In-Bug.png", width = "30px", height = "26px")),
            style = "color:#aaa; position:absolute; float:right; right: 60px;")
      ) 
    ),
    
    
    
    tabPanel(
      title = "Home",
      
      fluidRow(
        
        column(
          width = 2,
          br(),
          br(),
          img(src = "life_of_pi_hex.png", width = "100px", height = "110px"),
          tags$img(src = "logo.png", width = "200px", height = "100px")
        ),
        
        column(
          width = 9,
          
          p("Those who thought this app had something to do the movie, I'm sorry to disappoint.
      It has less to do with the movie and more to do with mathematician's favorite number, \\(\\pi\\)"),
          p("So what is \\(\\pi\\)?"),
          p("\\(\\pi\\) has been around since the inception of the earth,
            since it's the ratio of cirumference to the diamtere of a circle.
            So it's always been there! Waiting to be discovered by someone. "),
          
        ),
        
        column(
          width = 1,
          tags$img(src = "yellow.png", height = "200px", style = "position: absolute; top: 450px; right:10px;")
        )
        
        
        
        
      ),
    ),
    
    tabPanel(
      
      
      
      title = "Work",
      
      sidebarLayout(
        sidebarPanel(
          width = 3,
          
          
          
          numericInput("n", "Number of points", value = 10000, min = 100, max = 100001, step = 100, width = "100%") %>%
            shinyInput_label_embed(
              shiny_iconlink() %>%
                bs_embed_popover(
                  title = "n, range: (100-100000)",
                  content = "Most usual values: 100, 1000, 10000 & 100000.
                Special case: 10001.
                Other values of n will take some time to render and the animation won't be quite as smooth.",
                  placement = "right"
                )
            ),
          
          div(actionButton("run", "Let's run!", icon = icon("walking"), width = "40%"), align = "center"),
          hr(),
          div(h4("The Algorithm"), align = "center"),
          p("Let us inscribe a circle with unit radius (\\(r = 1)\\) in a square,
            then the area of the circle is, $$A = \\pi r^2 = \\pi$$"),
          p("And the length of the square would be 2\\(r\\), hence area, $$(2r)^2 = 4$$"),
          p("Now if we let some points fall freely on the square without any restrictions,
            $$P(a \\ point \\ falling \\ inside \\ the \\ circle) = \\pi/4$$"),
          p("Let \\(p\\) be the proportion of points falling inside the circle,
            we can calculate this proportion using Monte Carlo Simulation.
            Thus the equation becomes, $$p = \\pi/4 \\implies \\pi = 4 p$$"),
          p("We shall now estimate \\(pi\\) using the above equation.")
        ),
        
        mainPanel(
          width = 9,
          fluidRow(
            column(
              width = 6,
              imageOutput("anim1")
            ),
            column(
              width = 6,
              imageOutput("anim2")
            ),
            br(),
            br(),
            br()
          )
          
        )
      )
      
      
    )
  )
)