


library(gifski)

the_data = function(n) {
  x0 = 0  # origin
  y0 = 0  # origin
  
  set.seed(n)
  x = runif(n, -1, 1)
  y = runif(n, -1, 1)
  
  distances = ((x - x0)**2 + (y - y0)**2)**.5
  point = ifelse(distances < 1, "Inside", "Outside")
  id = 1:n
  pi_hat = round(cumsum(point == "Inside")/id * 4, 3)
  data = data.frame(id, x, y, distances, point, pi_hat)
  return(data)
}

estimate_pi = function(the_data) {
  n = nrow(the_data)
  p = sum(the_data$point == "Inside")/n
  pi_hat = round(4*p, 3)
  return(pi_hat)
}


make_anim1 = function(the_data) {
  
  n = nrow(the_data)
  
  c1 = ifelse(n == 100001, "#DA291C", "#393f47")  # color inside
  c2 = ifelse(n == 100001, "#006747", "#88837d")
  
  p1 = ggplot() +
    geom_circle(aes(x0 = 0, y0 = 0, r = 1), color = "#515960") +
    geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
              alpha = 0, color = "#515960") +
    geom_point(aes(x = x, y = y, group = seq_along(id), color = point), size = .7, data = the_data) +
    hrbrthemes::theme_ft_rc() +
    theme(plot.background = element_rect(fill = "#272b30"),
          panel.background = element_rect(fill = "#272b30", color = "#272b30"),
          legend.position = "none") +
    scale_color_manual(values = c(c1, c2)) + 
    labs(
      caption = "Can you smell the rain?"
    ) +
    transition_reveal(along = id)
  
  anim1 = animate(p1, nframes = 30, fps = 2,
                  width = 680, height = 600, res = 120,
                  renderer = gifski_renderer(loop = F))
  
  return(anim1)
}

make_anim2 = function(the_data) {
  p2 = ggplot(the_data) +
      geom_line(aes(x = id, y = pi_hat), color = "#E7553C") + 
    geom_hline(yintercept = pi, color = "#75AADB", alpha = .5) +
    hrbrthemes::theme_ft_rc() +
    ylim(0, 6) +
    theme(plot.background = element_rect(fill = "#272b30"),
          panel.background = element_rect(fill = "#272b30", color = "#272b30"),
          plot.title = element_text(color = "#88837d")) +
    labs(
      title = "estimated pi: {the_data$pi_hat[frame_along]}",
      caption = "The simulation in real time.
      Guess which line shows the original value!"
    ) +
    xlab("# of points") +
    transition_reveal(along = id)
  
  anim2 = animate(p2, nframes = 30, fps = 2,
                  width = 600, height = 500, res = 120,
                  renderer = gifski_renderer(loop = F))
  
  return(anim2)
}


## 
ns = c(100, 1000, 10000, 100000, 100001)