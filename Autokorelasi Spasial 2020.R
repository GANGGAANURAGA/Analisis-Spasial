# Data yang digunakan shapefile / .shp
library("maptools")
library("sf")
library("tmap")
library("tmaptools")
library("leaflet")
library("spdep")
map <- readShapeSpatial("jatim.shp")
names(map)
plot(map, main = "Jawa Timur", axes = TRUE)

## PEMBOBOT SPASIAL ##
#bobot queen contiguity 
queen.w <- poly2nb(map, row.names = map$KABKOTNO, queen = TRUE)
summary(queen.w)
#standarisasi matrik bobot queen
queen.wl <- nb2listw(queen.w, style = "W")
summary(queen.wl)

# bobot rook contiguity
rook.w <- poly2nb(map, row.names = map$KABKOTNO, queen = FALSE)
summary(rook.w)
#standarisasi matrik bobot rook
queen.wl <- nb2listw(rook.w, style = "W")
summary(queen.wl)

plot(map, border = "grey")

a <- plot(queen.w, coordinates(map), add = TRUE, col = "red")
a
b <- plot(rook.w, coordinates(map), add = TRUE, col = "yellow")
b

# knn
coords <- coordinates(map) 
head(coords, 5)

k1neigh <- knearneigh(coords, k = 1, longlat = TRUE) # 1-nearest neighbor
k2neigh <- knearneigh(coords, k = 2, longlat = TRUE) # 2-nearest neighbor
plot(knn2nb(k1neigh), coords, add=TRUE)
plot(knn2nb(k2neigh), coords, add=TRUE)


# Inverse weight matrix
dist.mat <- as.matrix(dist(coords, method = "euclidean"))
dist.mat[1:5, 1:5]

dist.mat.inv <- 1 / dist.mat # 1 / d_{ij}
diag(dist.mat.inv) <- 0 # 0 diagonal
dist.mat.inv[1:5, 1:5]

dim(dist.mat.inv)


## SPASIAL AUTOKORELASI ##

# import data non spatial
data <- readr::read_csv("jatim.csv")
head(data)
# View(data)

# library yang digunakan untuk manipulasi data -> filtering, mutate, piping dll
library("dplyr")
data1 <- data %>% 
  rename(
    Persentase_Kemiskinan = y,
  )
head(data1)
names(data1)
dim(data1)# untuk mengetahui dimensi data

#Global Morans'I
Persentase.kemiskinan <- data1$Persentase_Kemiskinan
globalMoran <- moran.test(Persentase.kemiskinan, listw = queen.wl)
globalMoran[["estimate"]][["Moran I statistic"]]
globalMoran[["p.value"]]
mplot <- moran.plot(Persentase.kemiskinan, listw = nb2listw(queen.w, style = "W"))
# help("moran.plot")
# Local Morans'I
localMoran <- localmoran(Persentase.kemiskinan,
                   listw = nb2listw(queen.w, style = "W"))
localMoran

moran.map <- cbind(map, localMoran)
names(moran.map)
# Plot local moran's
tm_shape(moran.map) +
  tm_fill(col = "Ii",
          style = "quantile",
          title = "local moran statistic") + tm_text("KABKOT", size = 0.4)

# Plot LISA clusters
quadrant <- vector(mode="numeric",length=nrow(localMoran))
m.kemiskinan <- data1$Persentase_Kemiskinan - mean(data1$Persentase_Kemiskinan)     
m.local <- localMoran[,1] - mean(localMoran[,1])    
signif <- 0.3 

# membuat kuadran
quadrant[m.kemiskinan >0 & m.local>0] <- 4  
quadrant[m.kemiskinan <0 & m.local<0] <- 1      
quadrant[m.kemiskinan <0 & m.local>0] <- 2
quadrant[m.kemiskinan >0 & m.local<0] <- 3
quadrant[localMoran[,5]>signif] <- 0   

# plot in r
brks <- c(0,1,2,3,4)
colors <- c("white","blue",rgb(0,0,1,alpha=0.4),rgb(1,0,0,alpha=0.4),"red")
plot(map,border="lightgray",col=colors[findInterval(quadrant,brks,all.inside=FALSE)])
box()
legend("topleft", legend = c("insignificant","low-low","low-high","high-low","high-high"),
       fill=colors,bty="n")

# help("legend")

