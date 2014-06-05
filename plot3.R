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
print("plot third png")
png(file="plot3.png", width=480, height=480)
lct = Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US")
m1 = min(myNewData$Sub_metering_1)
m2 = max(myNewData$Sub_metering_1)
plot(myNewData$DateTime, myNewData$Sub_metering_1, type="l", col="black", xaxt ="n", xlab="", ylab = "Energy sub metering", ylim=c(m1,m2))
par(new=TRUE)
plot(myNewData$DateTime, myNewData$Sub_metering_2, type="l", col="red", xaxt ="n", xlab="", ylab="", ylim=c(m1,m2))
par(new=TRUE)
plot(myNewData$DateTime, myNewData$Sub_metering_3, type="l", col="blue", xaxt ="n", xlab="", ylab="", ylim=c(m1,m2))
axis.POSIXct(1,at=seq(min(myNewData$DateTime), max(myNewData$DateTime) + 100, "days"), format="%a")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black", "red","blue"))
dev.off()
Sys.setlocale("LC_TIME", lct)