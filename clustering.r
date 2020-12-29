# developer activities csv file
activity <- read.csv(file = "/data/activities.csv", header = TRUE)
#column names of activities of developers csv file
colnames(activity)
head(activity)

library(plyr)

# duration column convert to date and time with an associated time zone
activity$duration = as.POSIXct(activity$duration, format="%H:%M:%S")
# function that calculates activity hour and activity duration in each session

ActivityData <- ddply(activity,
                      .(idesessionuuid, activewindow), function(x){
                        ActDur = sum(as.numeric(as.POSIXct(x[, "duration"])), na.rm = T)
                        ActHour = mean(as.numeric(format(as.POSIXct(x[, "triggeredat"], format="%H:%M:%S"),"%H")))
                        return(c(ActHour=ActHour, ActDur=ActDur))
                      })
# column names of activitie's data with activity hour and activity duration
colnames(ActivityData)
head(ActivityData)


# developer edits data
edits <- read.csv(file = "/data/edits.csv", header = TRUE)
colnames(edits)
edits$duration = as.POSIXct(edits$duration, format="%H:%M:%S")
EditDat <- ddply(edits,
                 .(idesessionuuid, activewindow), function(x){
                   EdtDur = sum(as.numeric(as.POSIXct(x[, "duration"])), na.rm = T)
                   EdtNoChang = sum(x[, "numberchanges"])
                   return(c(EdtDur=EdtDur, EdtNoChang=EdtNoChang))
                 })
colnames(EditDat)

# Merge
head(ActDat)
head(EditDat)

FnlDat <- merge(ActivityData, EditDat, by = c("idesessionuuid", "activewindow"))
dim(FnlDat)
head(FnlDat)
colnames(FnlDat)


# Clustering
Clust2 <- kmeans(FnlDat[, -c(1 : 2)], centers = 2)
plot(FnlDat[, -c(1 : 2)], col = Clust2$cluster)
points(Clust2$centers, col = 1:5, pch = 8)

Clust21 <- kmeans(FnlDat[, c(3 : 4)], centers = 2)
plot(FnlDat[, c(3 : 4)], col = Clust21$cluster)

# developer's navigations data
navigations <- read.csv(file = "/data/navigation.csv", header = TRUE)
colnames(navigations)
head(navigations)

as.numeric(as.POSIXct(edits$duration[1]))

hist(edits$numberchanges[edits$numberchanges<50],
     main = "Number of changes - less than 50",
     xlab = "Number of changes")


hist(as.numeric(format(as.POSIXct(navigations$triggeredat,format="%H:%M:%S"),"%H")),
     main = "Distribution of number of activity during a day",
     xlab = "Hour of a day")
