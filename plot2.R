#
# load file under ./data directory
#
print("Loading household power consumption table...")
library(data.table)
file = "./data/household_power_consumption.txt"
myData <- read.csv(file,sep=";",stringsAsFactors=F, na.strings="?")
#
#
print("format Data and Time...")
myData$Date <- as.Date(myData$Date,"%d/%m/%Y")
#
# filter data and make new datasets
#
print("Filtering data base on project requested and create myNewData")
needDate <- as.Date(c("2007-02-01","2007-02-02"))
myNewData <- myData[myData$Date %in% needDate,]
myNewData$DateTime <- paste(myNewData$Date, myNewData$Time)
myNewData$DateTime <- strptime(myNewData$DateTime,"%Y-%m-%d %H:%M:%S")

#
# plot according to project request
#
#
print("plot second png")
png(file="plot2.png", width=480, height=480)
lct = Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US")
plot(myNewData$DateTime, myNewData$Global_active_power, type="l", ylab = "Global Active Power (killowatts)", xlab = "", xaxt ="n")
axis.POSIXct(1,at=seq(min(myNewData$DateTime), max(myNewData$DateTime) + 100, "days"), format="%a")
dev.off()
Sys.setlocale("LC_TIME", lct)