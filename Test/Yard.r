NumNativePlants <- 16
NumNonNativePlants <- 47

PercWeNeed <- .65

TotalPlants <- NumNativePlants + NumNonNativePlants

f <- function() ( (.65/.35) * NumNonNativePlants - NumNativePlants)
f()

f1 <- function(y) ( (1 + .65/.35) * NumNonNativePlants - (1 + .65/.35)*y + NumNativePlants)
f1(44)

xs <- 0:100
plot(xs, f1(xs), type='l')

f4 <- function(x) (30 = 10*x)
f4(3)