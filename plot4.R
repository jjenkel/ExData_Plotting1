# load libraries
require (dplyr)
require (lubridate)

# read data - read all for simplicity, ~120 MB isn't too much
srcfile <- "./Data/household_power_consumption.txt"
dat <- read.csv(srcfile,header = TRUE, sep = ";",na.strings = "?")

# check dat parameters, should be 1 date, 1 time and 7 value columns; and 2,075,259 rows
str(dat)

# pair down to the correct days
dat <- dat[year(dmy(dat[,1])) == 2007 & month(dmy(dat[,1])) == 2 & day(dmy(dat[,1])) <= 2,]

# create composite date/time variable
dat <- mutate(dat, DateTime = dmy_hms(paste(dat$Date,dat$Time)))

### Code for plot 4
# open the png device
png(filename = "plot4.png",
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "white")

par(mfrow = c(2,2))

with(dat,
    # plot 4.1
    plot(x = dat$DateTime,
         y = dat$Global_active_power,
         type = "n",
         ylab = "Global Active Power",
         xlab = ""))
    # add the lines
    lines(x = dat$DateTime,
          y = dat$Global_active_power)
    # plot 4.2
with(dat,
     plot(x = dat$DateTime,
          y = dat$Voltage,
          type = "n",
          ylab = "Voltage",
          xlab = "datetime"))
    # add the lines
    lines(x = dat$DateTime,
          y = dat$Voltage)    
    # plot 4.3
with(dat,
    plot(x = dat$DateTime,
        y = dat$Sub_metering_1,
        type = "n",
        xlab = "",
        ylab = "Energy sub metering"))
    # add the lines
        lines(x = dat$DateTime,
            y = dat$Sub_metering_1,
            col = "black")
        lines(x = dat$DateTime,
            y = dat$Sub_metering_2,
            col = "red")
        lines(x = dat$DateTime,
            y = dat$Sub_metering_3,
            col = "blue")
        legend(x = "topright",
               y = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col = c("black","red","blue"),
               bty = "n",
               lty = 1)
    # plot 4.4
with(dat,
    plot(x = dat$DateTime,
         y = dat$Global_reactive_power,
         type = "n",
         ylab = "Global_reactive_power",
         xlab = "datetime"))
    # add the lines
    lines(x = dat$DateTime,
          y = dat$Global_reactive_power)
    
# turn off the device
dev.off
