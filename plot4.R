## Script that generates the first of the plots for the project.
## 1.- Read the file.
## 2.- Select only the rows that belong to the two required days. Both day and time are required.
## 3.- Convert the data to plot from factor to numeric.
## 4.- Create the plots in the requested PNG file.
## 4.1- Open the PNG device.
## 4.2- Change the parameters to define a 2x2 plot matrix.
## 4.3- Create each plot as normal.
## 4.4- Close the device.


# My locale is different from the one for the course.
# This change forces the names (among other things) to be shown in English.
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')

# Read the file and subset those rows that belong to the required dates
power <- read.csv("household_power_consumption.txt", sep=";", header = TRUE)
fullDate <- as.POSIXct(strptime(paste(power$Date, power$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S"))
# Remove the former Date and Time columns and put the new one in its place
power <- cbind(fullDate, power[,-(1:2)])
data <- subset(power, 
            power$fullDate >= as.POSIXct(strptime("01/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")) &
            power$fullDate < as.POSIXct(strptime("03/02/2007 00:00:00",format="%d/%m/%Y %H:%M:%S")))
# Cast the data to plot to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))

# Open device
png("plot4.png", width = 480, height = 480)
# Establish the 2x2 plot matrix
par(mfcol = c(2,2))
# Create first plot as in plot2.R (top-left)
plot(data$fullDate , data$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
# Create second plot as in plot3.R (bottom-left)
plot(data$fullDate, data$Sub_metering_1, type="l",  col="black", xlab="", ylab="Energy sub metering")
lines(data$fullDate, data$Sub_metering_2, type="l", col="red")
lines(data$fullDate, data$Sub_metering_3, type="l", col="blue")
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1, bty="n")
# Create third plot (top-right)
plot(data$fullDate , data$Voltage, type = "l", xlab="datetime", ylab = "Voltage")
# Create fourth plot (bottom-right)
plot(data$fullDate , data$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
# Close device
dev.off()