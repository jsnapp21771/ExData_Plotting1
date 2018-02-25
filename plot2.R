#! /usr/bin/Rscript

##  Read household power consumption data

power_con <- read.table("household_power_consumption.txt",skip=1,sep=";")

##  Assign name to data columns

names(power_con) <- c(
			 	 	"Date",
					"Time",
					"Global_active_power",
					"Global_reactive_power",
				    "Voltage",
				    "Global_intensity",
				    "Sub_metering_1",
				    "Sub_metering_2",
				    "Sub_metering_3")

##  subset power consumption data to January 2007

jan_usage <- subset(power_con,
                    power_con$Date=="1/2/2007" | power_con$Date =="2/2/2007")

##  Convert Date and Time into R objects

jan_usage$Date <- as.Date(jan_usage$Date, format="%d/%m/%Y")

jan_usage$Time <- strptime(jan_usage$Time, format="%H:%M:%S")

jan_usage[1:1440,"Time"] <- format(jan_usage[1:1440,"Time"],
						         "2007-02-01 %H:%M:%S")
								 
jan_usage[1441:2880,"Time"] <- format(jan_usage[1441:2880,"Time"],
                                 "2007-02-02 %H:%M:%S")

##  Open a png file as a plotting device

png(file="plot2.png")

##  Create the plot

plot(jan_usage$Time,
	as.numeric(as.character(jan_usage$Global_active_power)),
	type="l",
	xlab="",
	ylab="Global Active Power (kilowatts)") 

##  Add a title to the plot

title(main="Global Active Power Vs Time")

##  flush the output

dev.off()
