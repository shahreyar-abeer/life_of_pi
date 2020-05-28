



the_data = function(n) {
  x0 = 0  # origin x co-ordinate
  y0 = 0  # origin y co-ordinate
  
  x = runif(n, -1, 1)
  y = runif(n, -1, 1)
  
  distances = ((x - x0)**2 + (y - y0)**2)**.5
  point = ifelse(distances < 1, "Inside", "Outside")
  id = 1:n
  pi_hat = cumsum(point == "Inside")/id * 4
  
  data = data.frame(id, x, y, distances, point, pi_hat)
  return(data)
}


make_anim1 = function(the_data) {
  p1 = ggplot() +
    geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
    geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
              alpha = 0, color = "black") +
    geom_point(aes(x = x, y = y, group = seq_along(id), color = point), size = .5, data = the_data) +
    hrbrthemes::theme_ft_rc() +
    scale_color_manual(values = c("#b8e186", "red")) + 
    theme(plot.background = element_rect(fill = "#272b30"),
          panel.background = element_rect(fill = "#272b30", color = "#272b30"),
          legend.position = "none") +
    scale_y_continuous(expand = expansion()) +
    transition_reveal(along = id) 
  
  anim1 = animate(p1, nframes = 10, fps = 1, duration = 10,
                  width = 600, height = 500, res = 100,
                  renderer = gifski_renderer(loop = F, "anim.gif"))
  
  return(anim1)
}



a1 = make_anim1(d)

anim_save("anim.gif")
save_animation(a1, "aa.gif")

make_anim2 = function(the_data) {
  p2 = ggplot(the_data) +
    geom_line(aes(x = id, y = pi_hat)) + 
    geom_hline(yintercept = pi) +
    transition_reveal(along = id)
  
  anim2 = animate(p2, nframes = 20, fps = 2, duration = 10,
          width = 600, height = 500, res = 150,
          renderer = gifski_renderer(loop = F))
  return(anim2)
}


d = the_data(1000)

make_anim2(d)

make_anim1(d)


p2 = ggplot(d) +
  geom_line(aes(x = id, y = pi)) + 
  geom_hline(yintercept = pi) +
  transition_reveal(along = id)

animate(p2, nframes = 30, fps = 3, duration = 10,
        width = 800, height = 600, res = 150,
        renderer = gifski_renderer(loop = F))

make_anim2(d)


d = the_data(10000)

p1 = ggplot(d) +
  geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
  geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
            alpha = 0, color = "black") +
  geom_point(aes(x = x, y = y, color = point), size = .5) +
  hrbrthemes::theme_ft_rc() +
  scale_color_manual(values = c("#b8e186", "red")) + 
  theme(plot.background = element_rect(fill = "#272b30"),
        panel.background = element_rect(fill = "#272b30", color = "#272b30"),
        legend.position = "none")

ggplotly(p1) %>%
  animation_opts(redraw = FALSE)

p2 = ggplot(d) +
  geom_line(aes(x = id, y = pi_hat, frame = id)) + 
  geom_hline(yintercept = pi)

ggplotly(p2) %>% animation_opts(redraw = FALSE)


p <- ggplot(txhousing, aes(month, median)) +
  geom_line(aes(group = year), alpha = 0.3) +
  geom_smooth() +
  geom_line(aes(frame = year, ids = month), color = "red")

ggplotly(p) %>%
  animation_opts(1000)
