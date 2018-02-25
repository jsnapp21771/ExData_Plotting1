#! /usr/bin/Rscript

##  Execises from Project 1, using Rscript

png(file="plot1.png")

power_con <- read.table("household_power_consumption.txt", skip=1, sep=";")

names(power_con) <- c("Date",
			 	 "Time",
			 	 "Global_active_power",
			 	 "Global_reactive_power",
			 	 "Voltage",
			 	 "Global_intensity",
			 	 "Sub_metering_1",
			 	 "Sub_metering_2",
			 	 "Sub_metering_3")

jan_usage <- subset(power_con, power_con$Date=="1/2/2007" | power_con$Date =="2/2/2007")

##  create the basic histogram

hist(as.numeric(as.character(jan_usage$Global_active_power)),
	col="red",
	xlab="Global Active Power(kilowatts)")

##  add a label

title(main="Global Active Power")

dev.off()
