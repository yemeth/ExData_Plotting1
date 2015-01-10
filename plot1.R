## Script that generates the first of the plots for the project.
## 1.- Read the file.
## 2.- Select only the rows that belong to the two required days.
## 3.- Convert the data to plot from factor to numeric.
## 4.- Open the PNG device, write the graph and close the device.


# Read the file and subset those rows that belong to the required dates
power <- read.csv("household_power_consumption.txt", sep=";", header = TRUE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
data <- subset(power,
            power$Date >= as.Date("01/02/2007",format="%d/%m/%Y") &
            power$Date <= as.Date("02/02/2007",format="%d/%m/%Y"))

# Global_active_power is a factor. It is necessary to convert it to character first. 
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Create the plot
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()