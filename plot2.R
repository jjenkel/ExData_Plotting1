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

### Code for plot 2
# open the png device
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

# create the plot - empty at first (type = "n")
plot(x = dat$DateTime,
     y = dat$Global_active_power,
     type = "n",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
# add the lines
lines(x = dat$DateTime,
      y = dat$Global_active_power)

# turn off the device
dev.off