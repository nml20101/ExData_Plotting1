#read selected data
powerData <- read.table(pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'),header=F, sep=';',na.strings = "?")
#rename column names
colnames(powerData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" )
# combine data and time into one variable
dateTime <- strptime( paste(powerData$Date,powerData$Time), format="%d/%m/%Y %H:%M:%S")
# open png file for plotting
png(file="plot2.png", width=480, height=480)
plot(dateTime, powerData$Global_active_power, ylab = "Global Power (kilowatts)", xlab ="", type="l")
dev.off()
