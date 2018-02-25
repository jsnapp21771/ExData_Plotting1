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

jan_usage <- subset(power_con,power_con$Date=="1/2/2007" | power_con$Date =="2/2/2007")


##  Convert Date and Time into R objects

jan_usage$Date <- as.Date(jan_usage$Date, format="%d/%m/%Y")

jan_usage$Time <- strptime(jan_usage$Time, format="%H:%M:%S")

jan_usage[1:1440,"Time"] <- format(jan_usage[1:1440,"Time"],
						         "2007-02-01 %H:%M:%S")
								 
jan_usage[1441:2880,"Time"] <- format(jan_usage[1441:2880,"Time"],
                                 "2007-02-02 %H:%M:%S")

##  Open a png file as a plotting device

png(file="plot4.png")

##  Initialise a multplot object as a container for 4 plots

par(mfrow=c(2,2))

##  Plot the individual graphs

with(jan_usage, {

	plot(jan_usage$Time,as.numeric(as.character(jan_usage$Global_active_power)),
		type="l",
		xlab="",
		ylab="Global Active Power")
  
	plot(jan_usage$Time,as.numeric(as.character(jan_usage$Voltage)),
		type="l",
		xlab="datetime",
		ylab="Voltage")
		
  	plot(jan_usage$Time,jan_usage$Sub_metering_1,
		type="n",
		xlab="",
		ylab="Energy sub metering")

	##  Add line colors and legend for the final plot

	with(jan_usage,
		lines(Time,as.numeric(as.character(Sub_metering_1))))
		
	with(jan_usage,
		lines(Time,as.numeric(as.character(Sub_metering_2)),
		col="red"))
		
   	with(jan_usage,
		lines(Time,as.numeric(as.character(Sub_metering_3)),
		col="blue"))

    legend("topright",
		lty=1,
		col=c("black","red","blue"),
		legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		cex = 0.6)


	##  The example output in the course assignment shows the some
    ##  labels using underlines. Since that style is not used with
    ##  consistency, I'm assuming that is a typo in the assignment.


  	plot(jan_usage$Time,as.numeric(as.character(jan_usage$Global_reactive_power)),
		type="l",
		xlab="datetime",
		ylab="Global reactive power")
})

##  close the plot

dev.off()