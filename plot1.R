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
print("plot first png")
png(file="plot1.png", width=480, height=480)
hist(myNewData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")
dev.off()