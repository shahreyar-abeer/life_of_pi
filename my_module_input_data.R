#' @title Data Input module
#' 
#' @description Create UI for data input. It can accept csv and excel files.
#'  In case of excel files, it gives the option to choose between sheets
#'  The server tracks the upload data button and the submit button, so you may use them if necessary
#'  
#' @param id Module's id.
#' 
#' @return A \code{reactiveValues} with 4 slots:
#'  \itemize{
#'   \item \strong{upload} : event to determine whether a data has been uploaded.
#'   \item \strong{form} : event ot determine whether the 'done' button has been clicked.
#'   \item \strong{data} : \code{data.frame} the uploaded data
#'   \tiem \strong{name} : the name of the data.
#'  }
#'  
#' @export
#' 
#' @importFrom shiny fileInput selectInput uiOutput renderUI actionButton
#'  callModule reactive observeEvent eventReactive NS req validate need
#' @importFrom tools file_ext
#' @importFrom readxl excel_sheets
#' @importFrom rio import

dataInputUI = function(id){
  ns = NS(id)
  tagList(
    
    div(fileInput(ns("data"), buttonLabel = icon("database"), "Please choose a file (csv | excel)", accept = c("csv", ".csv", "xls", ".xls", "xlsx", ".xlsx")), align = "center"),
    div(uiOutput(ns("sheet_select_ui")), align = "center"),
    br(),
    div(actionButton(ns("form"), "Done"), align = "center")
  )
}


#' Server for the data input module
#' 
#' 
dataInput = function(input, output, session){
  
  
  
  ns = session$ns
  
  
  
  ext = reactive({
    req(input$data)
    e = tools::file_ext(input$data$name)
    validate(
      need(e %in% c("csv", "xls", "xlsx"), "File format not supported!")
    )
    e
  })
  
  observeEvent(input$data, {
    
    output$sheet_select_ui = renderUI({
      if(ext() %in% c("xls", "xlsx")){
        selectInput(ns("sheet_no"), "Sheet number", choices = 1:length(excel_sheets(input$data$datapath)))
      }
    })
  })
  
  
  # the name of the data
  name = eventReactive(input$data, {
    req(ext())
    input$data$name
  })
  
  ### reading the data with rio::import
  data = eventReactive(input$data, {
    req(ext())
    rio::import(input$data$datapath, which = as.numeric(input$sheet_no))
  })
  
  
  return(list(
    upload = reactive(input$data), # the upload button
    form = reactive(input$form), # the submit button
    data = data, # the data
    name = name # name of the data file
  ))
  
}


# an example
# ui = navbarPage(title = "Writing my first module",
#   tabPanel("Home",
#            dataInputUI("one"))
# )
# 
# 
# server = function(input, output){
#   d = callModule(dataInput, "one")
# }
# 
# 
# shinyApp(ui = ui, server = server)