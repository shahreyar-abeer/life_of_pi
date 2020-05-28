

library(ggplot2)
library(gganimate)
library(ggforce)

x1 = runif(100, -1, 1)
y1 = runif(100, -1, 1)
type = factor(sample(c("In", "Out"), 100, replace = T))
t = 1:100

d = data.frame(x1, y1, t, type)

p = ggplot() + 
  geom_circle(aes(x0 = 0, y0 = 0, r = 1)) +
  geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
            alpha = 0, color = "white") +
  geom_point(aes(x = x1, y = y1, group = seq_along(t), color = type), data = d) +
  hrbrthemes::theme_ft_rc() +
  scale_color_manual(values = c("#b8e186", "red")) + 
  transition_reveal(along = t)

animate(p, nframes = 10, width = 800, height = 600, renderer = gifski_renderer(loop = F))  






animate(p, nframes = 10, renderer = magick_renderer(loop = F))



  library(ggplot2)

ggplot(iris) +
 aes(x = Sepal.Length, y = Sepal.Width, colour = Species, size = Petal.Length) +
 geom_point() +
 scale_color_brewer(palette = "PiYG") +
 hrbrthemes::theme_ft_rc() +
 annotate("text", x = Inf, y = -Inf, label = "© Moayed Alawami", hjust = 2.7, vjust = -21.1, col = "gray", cex = 8, fontface = "bold", alpha = 1)
