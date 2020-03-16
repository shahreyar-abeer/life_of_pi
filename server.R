


library(ggplot2)
library(gganimate)
library(ggforce)

server = function(input, output){
  
  
  
  output$anim1 = renderImage({
    
    n = input$n
    
    x1 = runif(n, -1, 1)
    y1 = runif(n, -1, 1)
    type = factor(sample(c("In", "Out"), n, replace = T))
    t = 1:n
    
    d = data.frame(x1, y1, t, type)
    
    p = ggplot() + 
      geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
      geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
                alpha = 0, color = "black") +
      geom_point(aes(x = x1, y = y1, group = seq_along(t), color = type), data = d) +
      #hrbrthemes::theme_ft_rc() +
      scale_color_manual(values = c("#b8e186", "red")) + 
      transition_reveal(along = t)
    
    
      
    an = animate(p, nframes = 10, width = 800, height = 600, res = 150, renderer = gifski_renderer(loop = F))  
    
    
    
    outfile <- tempfile(fileext='.gif')
    
    save_animation(an, outfile)
    
    #anim_save("outfile.gif", animation = an)
    
     
    
    list(src = outfile,
         contentType = 'image/gif'
          #alt = "This is alternate text"
    )
    
  }, deleteFile = TRUE)
}