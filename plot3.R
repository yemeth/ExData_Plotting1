## Script that generates the first of the plots for the project.
## 1.- Read the file.
## 2.- Select only the rows that belong to the two required days. Both day and time are required.
## 3.- Convert the data to plot from factor to numeric.
## 4.- Open the PNG device, write the graph and close the device.


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
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# Open the device.
png("plot3.png", width = 480, height = 480)
# Create the plot with the first series.
plot(data$fullDate, data$Sub_metering_1, type="l",  col="black", xlab="", ylab="Energy sub metering")
# Write over the plot to add the second series.
lines(data$fullDate, data$Sub_metering_2, type="l", col="red")
# Write over the plot to add the third series.
lines(data$fullDate, data$Sub_metering_3, type="l", col="blue")
# Write over the plot to add the legend at the desired position.
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)
dev.off()