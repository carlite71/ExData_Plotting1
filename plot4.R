raw_data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings="?")

library(dplyr)


# subsets only the data we need
small_data = filter(raw_data, Date == "2/2/2007" | Date == "1/2/2007")

small_data$DateTime = paste(small_data$Date, small_data$Time)

small_data$DateTimeParsed = strptime(small_data$DateTime, "%d/%m/%Y %H:%M:%S")

plotready = 
  small_data %>%
  mutate(Global_active_power = as.numeric(Global_active_power))%>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Voltage = as.numeric(Voltage)) %>%
  mutate(Global_intensity = as.numeric(Global_intensity)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3))

par(mfrow=c(2,2))

# creates global active power plot
with(plotready, plot(DateTimeParsed, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# creates voltage plot
with(plotready, plot(DateTimeParsed, Voltage, type="l", xlab="datetime", ylab="Voltage"))


# creates the submetering plot
plot(plotready$DateTimeParsed, plotready$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(plotready$DateTimeParsed, plotready$Sub_metering_2, type="l", col = "red")
lines(plotready$DateTimeParsed, plotready$Sub_metering_3, type ="l", col = "blue")

legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), bty="n", lwd=c(2.5,2.5), col=c("black", "blue", "red"), cex= .75, seg.len = 3)

# creates global reactive power plot
with(plotready, plot(DateTimeParsed, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))



# copy plot to png device
dev.copy(png, file = "plot4.png")
dev.off()
