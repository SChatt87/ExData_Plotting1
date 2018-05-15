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

#Plot 1

hist(ucihousehold$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "Red")

dev.copy(png,'Plot1.png')
dev.off()




