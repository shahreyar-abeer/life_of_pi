library(ggplot2)
library(gganimate)
library(ggforce)

fr <- 100 # number of iterations
set.seed(314)

df <- data.frame(t = 1:fr, x = runif(fr, -1, 1), y = runif(fr, -1, 1))
df$dist <- df$x^2 + df$y^2
df$inCircle <- df$dist <= 1
df$pi_estimate <- format(4*cumsum(df$inCircle)/1:fr, format = 'f', digits = 4)

p <- ggplot() + theme_bw() + theme(panel.grid.major = element_blank(),
                                   panel.grid.minor = element_blank(),
                                   panel.border = element_blank(),
                                   panel.background = element_blank())
p <- p + geom_circle(aes(x0 = 0, y0 = 0, r = 1), color = "black")
p <- p + geom_rect(aes(xmin = -1, ymin = -1, xmax = 1, ymax = 1), color = "black", alpha = 0) + guides(color = FALSE)
p <- p + geom_point(data = df, aes(x = x, y = y, color = inCircle), size = 3) + guides(color = FALSE)

p <- p + scale_colour_manual(values=c("#fc8d59", "#00BA38"))
p <- p + transition_manual(t, cumulative = TRUE)

p <- p + labs(title = "Estimating pi with Monte-Carlo Integration",
              subtitle = "n = {frame}, pi = 4 * {cumsum(df$inCircle)[as.integer(previous_frame)]} / {as.integer(previous_frame)} = {df$pi_estimate[as.integer(previous_frame)]}")

# to plot on screen:
# animate(p, fps = 10, duration = 30, end_pause = 100)
# to export:
anim_save("plot1.gif", p, fps = 10, duration = 30, end_pause = 100, width = 300, height = 300)

# Bonus: visualize the progress of the algorithm
p2 <- ggplot(data = df, aes(x = t, y = 4*cumsum(df$inCircle)/1:fr)) + theme_bw()
p2 <- p2 + geom_line()
p2 <- p2 + geom_hline(yintercept = pi, linetype = "longdash")
p2 <- p2 + geom_text(x = 0.95 * fr, y = 3.3, label="Pi")
p2 <- p2 + ylab("pi estimate")
p2 <- p2 + transition_manual(t, cumulative = TRUE)
animate(p2,fps = 10, duration = 30)
