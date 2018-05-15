library(dplyr)
library(lubridate)
options(digits=9)

setwd("~/coursera/baseplots")
getwd()

if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl1,destfile="./data/ucihousehold.zip",method="curl")
unzip(zipfile="./data/ucihousehold.zip",exdir="./data")

path.files <- file.path("./data")
ucihousehold <- read.table(file.path(path.files,"household_power_consumption.txt"), sep = ";", header = TRUE)
ucihousehold$Datetime <- as.POSIXct(strptime(paste(as.Date(dmy(ucihousehold$Date)), ucihousehold$Time), format="%Y-%m-%d %H:%M:%S"))
ucihousehold <- ucihousehold[which(ucihousehold$Datetime >= as.Date("2007-02-01") & ucihousehold$Datetime < as.Date("2007-02-03")),]
ucihousehold <- tbl_df(ucihousehold)
ucihousehold[,3:9] <- lapply(ucihousehold[, 3:9], function(x) as.numeric(as.character(x)))
ucihousehold[, 3:9] <- lapply(ucihousehold[, 3:9], function(x) as.numeric(gsub("?", NA, x,fixed = TRUE)))


#Plot 3

with(ucihousehold,plot(Datetime,Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(ucihousehold,lines(Datetime,Sub_metering_1))
with(ucihousehold,lines(Datetime,Sub_metering_2, col = "red"))
with(ucihousehold,lines(Datetime,Sub_metering_3, col = "blue"))
legend("topright",lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,'Plot3.png')
dev.off()
