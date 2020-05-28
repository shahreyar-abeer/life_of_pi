


x = c(-1, 1)

get_distance = function(x, y){
  d = sqrt(sum((x - y)^2))
  return(d)
}

set.seed(59)
n = 10000000
p0 = c(0, 0)
k = 0

for(i in 1:n){
  x1 = runif(1, -1, 1)
  y1 = runif(1, -1, 1)
  p1 = c(x1, y1)
  d1 = get_distance(p1, p0)
  if(d1 < 1)
    k = k + 1
}

k/n*4


n = 10000000

x0 = 0
y0 = 0

x = runif(n, -1, 1)
y = runif(n, -1, 1)

ds = ((x - x0)**2 + (y - y0)**2)**.5
p = sum(ds < 1)/n

pi_hat = 4*p
pi_hat
