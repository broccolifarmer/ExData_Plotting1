# read the file in, it must be unzipped and directly in your workspace

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# convert the Date column to be a Date

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset the data for the dates we are interested in

sub <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# add a DateTime column

sub$DateTime <- strptime((paste(sub$Date,sub$Time)), format = "%Y-%m-%d %H:%M:%S")

# open png device
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# plot the graphs
par(mfrow=c(2,2))

# top left
plot(sub$DateTime,sub$Global_active_power, ylab = "Global Active Power", type = "l", xlab = "")

# top right
plot(sub$DateTime,sub$Voltage, type = "l", xlab = "", ylab = "Voltage")

# bottom left
plot(sub$DateTime, sub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(sub$DateTime, sub$Sub_metering_2, type = "l", col = "Red")
lines(sub$DateTime, sub$Sub_metering_3, type = "l", col = "Blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("Black","Red","Blue"), lty = 1, bty = "n")

# bottom right
plot(sub$DateTime,sub$Global_reactive_power, type = "l", xlab = "", ylab = "Global Reactive Power")

# close png device
dev.off()