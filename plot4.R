#read selected data
powerData <- read.table(pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),header=F, sep=';',na.strings = "?")
#rename column names
colnames(powerData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )
# combine data and time into one variable
dateTime <- strptime( paste(powerData$Date,powerData$Time), format="%d/%m/%Y %H:%M:%S")
# open png file for plotting
png(file="plot4.png", width=480, height=480)
# create 2x2 matrix of plots on one graph
par(mfrow=c(2,2))

#top left graph
plot(dateTime, powerData$Global_active_power, ylab = "Global Power (kilowatts)", xlab ="", type="l")

#top right graph
plot(dateTime, powerData$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

#lower left graph
plot(dateTime, powerData$Sub_metering_1, type="l", main ="", ylab="Energy sub metering", xlab="")
lines(dateTime,powerData$Sub_metering_2,col="red", type="l")
lines(dateTime,powerData$Sub_metering_3,col="blue", type="l")
#legend("topright", pch=NA_integer_, bty="n", cex=0.85, y.intersp = 0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
legend("topright", pch=NA_integer_, lty=1, cex=0.9, y.intersp = 0.85, bty="n", box.lwd = 1, text.font = 2,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#lower right graph
plot(dateTime, powerData$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

# close device

dev.off()
