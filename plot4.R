## load required packages
library(dplyr)
## load data
data <- read.delim("./data/household_power_consumption.txt", header=TRUE, sep = ";")
## subset data from 1/2/2007-2/2/2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
## replace '?' with NAs
data <- na_if(data, "?")
## mutate time and date variables into single col
data <- mutate(data,Date.Time=paste(data$Date,data$Time))
data <- select(data,Date.Time,Global_active_power:Sub_metering_3,-Date,-Time)
data$Date.Time <- strptime(data$Date.Time,"%d/%m/%Y %T")
## plot 4 to png
png(file="Plot4.png",width=480,height=480)
par(mfrow=c(2, 2))
plot(data$Date.Time, data$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
plot(data$Date.Time, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(data$Date.Time, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
points(data$Date.Time, data$Sub_metering_1, type = "l")
points(data$Date.Time, data$Sub_metering_2, type = "l", col = "red")
points(data$Date.Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", 
                                       "Sub_metering_3"), col = c("black", "red", "blue"), box.lwd = 0)
plot(data$Date.Time, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
## save to png file
dev.off()
