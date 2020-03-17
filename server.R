


library(ggplot2)
library(gganimate)
library(ggforce)

server = function(input, output){
  
  
  observeEvent(input$run, {
    d1 = the_data(input$n)
    
    output$anim1 = renderImage({
      anim1 = make_anim1(d1)
      
      outfile <- tempfile(fileext='.gif')
      save_animation(anim1, outfile)
      
      list(src = outfile,
           contentType = 'image/gif'
           #alt = "This is alternate text"
      )
      
    }, deleteFile = TRUE)
    
    ##############################################
    output$anim2 = renderImage({
      anim2 = make_anim2(d1)
      
      outfile <- tempfile(fileext='.gif')
      save_animation(anim2, outfile)
      
      list(src = outfile,
           contentType = 'image/gif'
           #alt = "This is alternate text"
      )
      
    }, deleteFile = TRUE)
  })
  
  
  
  # output$value = bs4Dash::renderbs4ValueBox({
  #   bs4Dash::valueBox(value = 2, subtitle = "Pi")
  # })
  
}