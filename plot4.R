#############################################################################################
### Individual household electric power consumption Data Set from UCI Irvine Machine Learning 
### Repositry 
### This file plots Constructs a plot as described by the course and saves it to a PNG file 
### with a width of 480 pixels and a height of 480 pixels. 
#############################################################################################

## Read in the data and select only the dates from 2007-02-01 and 2007-02-02
df <- read.table("~/exdata-data-household_power_consumption/household_power_consumption.txt", header = T, stringsAsFactors = F, sep = ";" )
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df <- with(df, df[(Date >= "2007-02-01" & Date <= "2007-02-02") , ])

## Converting Time Columns 
df$Time <- strptime(df$Time,  format = "%H:%M:%S")
df$Time <- strftime(df$Time, "%H:%M:%S")

## Merge Date Time Columns 
df$datetime <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

## Converting columns from factor to numeric 
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)

## Remove dataset missing values (coded as ?) from the data frame
# Step not needed as there was none in the subsetted data frame. 

## Plot a Histogram of "Sub metering 1,2,3"
png("plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))
plot(df$datetime, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", pch = "")
lines(df$datetime, df$Global_active_power,col = "black", lty = "solid")
plot(df$datetime, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", pch = "")
lines(df$datetime, df$Sub_metering_1,col = "black", lty = "solid")
lines(df$datetime, df$Sub_metering_2,col = "red", lty = "solid")
lines(df$datetime, df$Sub_metering_3,col = "blue", lty = "solid")
legend("topright", pch = "", lty = c("solid","solid","solid"), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
plot(df$datetime, df$Voltage, xlab = "datetime", ylab = "Voltage", pch = "")
lines(df$datetime, df$Voltage,col = "black", lty = "solid")
plot(df$datetime, df$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", pch = "")
lines(df$datetime, df$Global_reactive_power,col = "black", lty = "solid")
dev.off()