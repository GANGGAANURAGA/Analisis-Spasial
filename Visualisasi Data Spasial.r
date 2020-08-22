## Visualisasi Data Spasial ##

# Beberapa library yang digunakan
library("sf")
library("tmap")
library("tmaptools")
library("leaflet")


# import data 
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

dim(data1)# untuk mengetahui dimensi data
# View(data1) 

# import data shapefile / .shp
map <- st_read("jatim.shp", stringsAsFactors = FALSE)
 
# str(map) # digunakan untuk mengetahui karakter struktur data

map_data <- merge(map,data1) # menggabungkan data .csv + .shp
names(map_data)
str(map_data)
# View(map_data)

map2 <- tm_shape(map_data) + 
  tm_polygons("Persentase_Kemiskinan", style = "quantile", n = 3, palette = "Greens") + 
  tm_legend(outside = FALSE) + tm_text("KABKOT", size = 0.3) +
  tm_layout(main.title = "Persebaran Kemiskinan di Jawa Timur", title.size = 0.8)
map2

# help("tm_text")
# help("tm_layout")


tmap_save(map2, "Persebaran Persentase Kemiskinan Jawa Timur.png", width=1920, height=1080)

map3 <- tm_shape(map_data) +
  tm_polygons("Persentase_Kemiskinan", title = "Persentase Kemiskinan", palette = "-GnBu",
              style = "kmeans",
              legend.hist = T) +
  tm_scale_bar(width = 0.22, position = c("right", "top")) +
  tm_compass()+
  tm_layout(frame = F, main.title = "Persebaran Kemiskinan Jawa Timur", 
            title.size = 2, 
            #title.position = c(0.55, "top"), 
            legend.hist.size = 0.5, 
            legend.outside = T) +
  tm_text("KABKOT", size = 0.3)
map3

tmap_save(map3, "Persebaran Kemiskinan Provinsi Jawa Timur.png", width=1920, height=1080)

# Pengelompokan wilayah berdasarkan kelas interval
p1 <- tm_shape(map_data) +
  tm_polygons("Persentase_Kemiskinan", title = "% Kemiskinan", palette = "Blues") +
  tm_layout(legend.title.size = 1, main.title = "% Kemiskinan Jawa Timur (Interval Kelas)",
            main.title.size = 0.7)
# Pengelompokan wilayah berdasarkan algoritma klaster kmeans
p2 <- tm_shape(map_data) +
  tm_polygons("Persentase_Kemiskinan", title = "% Kemiskinan", palette = "Greens",
              style = "kmeans") +
  tm_layout(legend.title.size = 1, main.title = "% Kemiskinan Jawa Timur (K-Means)",
            main.title.size = 0.7)

multiple.map <- tmap_arrange(p1, p2, nrow = 1, ncol = 2)
multiple.map

# Point
# 1st layer
pts_sf <- st_centroid(map_data)
tm_shape(map_data) +
  tm_fill("olivedrab4") +
  tm_borders("grey", lwd = 1) +
  tm_text("KABKOT", size = 0.3) +
    # the points layer
  tm_shape(pts_sf) +
  tm_bubbles("Persentase_Kemiskinan", title.size = "% Kemiskinan", col = "gold")

# help("tm_bubbles")

# Interaktif Map
# tmap_mode("view")

# tmap_last()


# Statistik Deskriptif : menyajikan data dalam bentuk ukuran pemusatan
# ukuran penyebaran, grafik/diagram, tabel
names(data1)
dim(data1)
dataframe <- data.frame(data1)
dataframe <- data1[c(6:19)] 
dim(dataframe)
names(dataframe)

summary(dataframe[-1], stats = commons)

library("summarytools")
descr(dataframe[-1],
     stats = "common") # most common descriptive statistics

# Histogram
hist(dataframe$Persentase_Kemiskinan)

# Boxplot 
x4 <- dataframe$x4
x7 <- dataframe$x7
x10 <- dataframe$x10
boxplot(x4,x7,x10, names = c("x4", "x7", "x10"),
        xlab="Indikator",
        ylab="Data",
        col="orange",
        border="brown", main = " Indikator Kemiskinan Jatim")

# Scatterplot
plot(x10, x4)

library(corrplot)
library(RColorBrewer)
dataframe1 <- dataframe %>% 
  rename(
    y = Persentase_Kemiskinan,
  )
head(dataframe1)
M <-cor(dataframe1[-1])
corrplot(M, type="upper", order="hclust",
         col=brewer.pal(n=8, name="RdYlBu"))

library("PerformanceAnalytics")
my_data <- dataframe1[-1]
chart.Correlation(my_data, histogram=TRUE, pch=19)
