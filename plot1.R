raw_data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings="?")

library(dplyr)
library(tidyr)


# subsets only the data we need
small_data = filter(raw_data, Date == "2/2/2007" | Date == "1/2/2007")

plotready = 
  small_data %>%
  mutate(Global_active_power = as.numeric(Global_active_power))%>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Voltage = as.numeric(Voltage)) %>%
  mutate(Global_intensity = as.numeric(Global_intensity)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3))


# creates plot
hist(plotready$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# copy plot to png device
dev.copy(png, file = "plot1.png")
dev.off()

