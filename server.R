


library(ggplot2)
library(gganimate)
library(ggforce)

server = function(input, output){
  
  waitress1 = Waitress$new("#anim1", infinite = TRUE)
  waitress2 = Waitress$new("#anim2", infinite = TRUE)
  
  observeEvent(input$run, {
    d1 = the_data(input$n)

    output$anim1 = renderImage({
      
      
      waitress1$start(h3("Good things take time"))
      
      anim1 = make_anim1(d1)
      
      outfile <- tempfile(fileext='.gif')
      save_animation(anim1, outfile)
      
      waitress1$close()
      
      list(src = outfile,
           contentType = 'image/gif'
           #alt = "This is alternate text"
      )
      
      
      
    }, deleteFile = TRUE)
    
    ##############################################
    output$anim2 = renderImage({
      
      waitress2$start(h3("It goes again"))
      
      anim2 = make_anim2(d1)
      
      outfile <- tempfile(fileext='.gif')
      save_animation(anim2, outfile)
      
      waitress2$close()
      
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