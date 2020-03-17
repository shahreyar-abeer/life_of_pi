

the_data = function(n) {
  x0 = 0  # origin x co-ordinate
  y0 = 0  # origin y co-ordinate
  
  x = runif(n, -1, 1)
  y = runif(n, -1, 1)
  
  distances = ((x - x0)**2 + (y - y0)**2)**.5
  point = ifelse(distances < 1, "Inside", "Outside")
  id = 1:n
  data = data.frame(id, x, y, distances, point)
  return(data)
}

estimate_pi = function(the_data) {
  n = nrow(the_data)
  p = sum(the_data$point == "Inside")/n
  pi_hat = 4*p
  return(pi_hat)
}


make_anim1 = function(the_data) {
  p1 = ggplot() +
    geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
    geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
              alpha = 0, color = "black") +
    geom_point(aes(x = x, y = y, group = seq_along(id), color = point), size = .4, data = the_data) +
    hrbrthemes::theme_ft_rc() +
    scale_color_manual(values = c("#b8e186", "red")) + 
    transition_reveal(along = id)
  
  anim1 = animate(p1, nframes = 10, fps = 2,
                  width = 800, height = 600, res = 150,
                  renderer = gifski_renderer(loop = F))
  
  return(anim1)
}
