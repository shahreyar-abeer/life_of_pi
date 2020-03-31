


library(ggplot2)
library(gganimate)
library(ggforce)
library(glue)

server = function(input, output){
  
  
  shinyjs::addClass(id = "text", class = "navbar-right")
  
  waitress1 = Waitress$new("#anim1", theme = "overlay-radius", infinite = TRUE)
  waitress2 = Waitress$new("#anim2", infinite = TRUE)
  
  observeEvent(input$run, {
    
    
    n = input$n
    d1 = the_data(n)

    output$anim1 = renderImage({
      
      w11 = Waitress$new("#anim1")$start(h5("Here goes"))
      #waitress1$start(div(h5("Science doesn't run the world..."), style = "color: #88837d;"))
      
      if(n %in% ns) {
        
        filename <- normalizePath(
          file.path('./anims2', glue("anim1_{n}.gif"))
        )
        
        for(i in 1:10){
          w11$inc(10)
          Sys.sleep(.2)
        }
        
        
        w11$close()
        list(src = filename,
             contentType = 'image/gif'
        )
        
      }
      
      else{
        anim1 = make_anim1(d1)
        
        outfile <- tempfile(fileext='.gif')
        save_animation(anim1, outfile)
        
        
        waitress1$close()
        
        list(src = outfile,
             contentType = 'image/gif'
        )
      }
      
      
    }, deleteFile = FALSE)
    
    ##############################################
    output$anim2 = renderImage({
      
      if(n %in% ns) {
        waitress2$start(div(h5("Science just says how the world runs"), style = "color: #88837d;"))
        
        filename <- normalizePath(
          file.path('./anims2', glue("anim2_{n}.gif"))
        )
        Sys.sleep(2)
        waitress2$close()
        list(src = filename,
             contentType = 'image/gif'
        )
        
      }
      
      else {
        anim2 = make_anim2(d1)
        
        outfile <- tempfile(fileext='.gif')
        save_animation(anim2, outfile)
        
        waitress2$close()
        
        list(src = outfile,
             contentType = 'image/gif'
             #alt = "This is alternate text"
        )
      }
    }, deleteFile = FALSE)
  })
  
}