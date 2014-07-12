#read selected data
powerData <- read.table(pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),header=F, sep=';',na.strings = "?")
#rename column names
colnames(powerData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )
# combine data and time into one variable
dateTime <- strptime( paste(powerData$Date,powerData$Time), format="%d/%m/%Y %H:%M:%S")
# open png file for plotting
png(file="plot3.png", width=480, height=480)
#plot selected data
with(powerData, plot(dateTime, powerData$Sub_metering_1, type="l", main ="", ylab="Energy sub metering", xlab=""))
lines(dateTime,powerData$Sub_metering_2,col="red", type="l")
lines(dateTime,powerData$Sub_metering_3,col="blue", type="l")
legend("topright", pch=NA_integer_, lty=1, cex=0.9, y.intersp = 0.85, box.lwd = 1, text.font = 2,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# close device
dev.off()
