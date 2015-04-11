# read the file in, it must be unzipped and directly in your workspace

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# convert the Date column to be a Date

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# subset the data for the dates we are interested in

sub <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# add a DateTime column

sub$DateTime <- strptime((paste(sub$Date,sub$Time)), format = "%Y-%m-%d %H:%M:%S")

# plot the line graph

plot(sub$DateTime,sub$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab = "")

# copy to png file

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
dev.off()