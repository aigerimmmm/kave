activities <- read.csv(file = "/data/activities.csv", header = TRUE)
users <- read.csv(file = "/data/users.csv", header = TRUE)
edits <- read.csv(file = "/data/edits.csv", header = TRUE)
navigations <- read.csv(file = "/data/navigation.csv", header = TRUE)
debuggers <- read.csv(file = "/data/debugger.csv", header = TRUE)
builds <- read.csv(file = "/data/build.csv", header = TRUE)

# activities that in users file
activitiesU <- activities[activities$idesessionuuid %in% users$idesessionuuid, ]
editsU <- edits[edits$idesessionuuid %in% users$idesessionuuid, ]
debuggersU <- debuggers[debuggers$idesessionuuid %in% users$idesessionuuid, ]
buildsU <- builds[builds$idesessionuuid %in% users$idesessionuuid, ]

activitiesU$durationT = as.POSIXct(activitiesU$duration, format="%H:%M:%S")
editsU$durationT = as.POSIXct(editsU$duration, format="%H:%M:%S")
debuggersU$durationT = as.POSIXct(debuggersU$duration, format="%H:%M:%S")
buildsU$durationT = as.POSIXct(buildsU$duration, format="%H:%M:%S")

# add activity duration to activities that in users file
ActDat <- ddply(activitiesU,
                .(idesessionuuid, activewindow), function(x){
                  ActDur = sum(as.numeric(format(strptime(x[, "durationT"], "%Y-%m-%d %H:%M:%S"), "%S")) +
                                 as.numeric(format(strptime(x[, "durationT"], "%Y-%m-%d %H:%M:%S"), "%M")) / 60, na.rm = T)
                  return(c(ActDur = ActDur))
                })
# add edit duration to edits that in users file
EdtDat <- ddply(editsU,
                .(idesessionuuid, activewindow), function(x){
                  EdtDur = sum(as.numeric(format(strptime(x[, "durationT"], "%Y-%m-%d %H:%M:%S"), "%S")) +
                                 as.numeric(format(strptime(x[, "durationT"], "%Y-%m-%d %H:%M:%S"), "%M")) / 60, na.rm = T)
                  return(c(EdtDur = EdtDur))
                })

# merge activity duration and edit duration that in users file
FnlDat <- merge(ActDat, EdtDat,
                by = c("idesessionuuid", "activewindow"))

# merged activity duration and edit duration that in users file merge with users file
FnlDat <- merge(FnlDat, users[, c("idesessionuuid", "programmingGeneral",
                                  "education", "position", "codeReviews",
                                  "programmingCSharp")],
                by = c("idesessionuuid"))



# Clustering
Clust2 <- kmeans(FnlDat[, -c(1 : 2)], centers = 2)
plot(FnlDat[, -c(1 : 2)], col = Clust2$cluster)
points(Clust2$centers, col = 1:5, pch = 8)

names(Clust2)


Clust3 <- kmeans(FnlDat[, -c(1 : 2)], centers = 3)
plot(FnlDat[, -c(1 : 2)], col = Clust3$cluster)
points(Clust3$centers, col = 1:5, pch = 8)


Clust4 <- kmeans(FnlDat[, -c(1 : 2)], centers = 4)
plot(FnlDat[, -c(1 : 2)], col = Clust4$cluster)
points(Clust4$centers, col = 1:5, pch = 8)



# PCA
PCA1 <- prcomp(FnlDat[, -c(1 : 2)], center = T, scale. = T)
PCA1

plot(PCA1, type = "l")

library(devtools)
remotes::install_github('vqv/ggbiplot')
library(ggbiplot)

FnlDat$programmingGeneralSkilled <- factor(ifelse(FnlDat$programmingGeneral>=4, "Pro", "Non-pro"))

g <- ggbiplot(PCA1, obs.scale = 1, var.scale = 1, 
              groups = FnlDat$programmingGeneralSkilled, ellipse = T, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)


Clust2_C <- kmeans(PCA1$x[, c(1 : 2)], centers = 2)
plot(PCA1$x[, c(1 : 2)], col = Clust2_C$cluster)
points(Clust2$centers, col = 1:5, pch = 8)
