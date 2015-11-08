#Please change the working directory in the line below to your directory
#containing household_power_consumption.txt

wd <- "D:/Ucheba/Data Science Specialization/04 Exploratory data analysis/Week 1/CP1"

setwd(wd)

##########################


# preserve the existing locale
my_locale <- Sys.getlocale("LC_ALL")


# change locale to English
#Otherwise I get Russian name of days of the week!
Sys.setlocale("LC_ALL", "English")


#Load neccesary packages. The script checks if they are installe and installs if not so.

list.of.packages <- c("dplyr", "readr", "lubridate")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)
library(readr)
library(lubridate)

#Read the file
D <- read_delim("household_power_consumption.txt", delim=";", col_types = "ccnnnnnnn", na="?")

#Extract the data for 1st and 2nd Feb of 2007 using filter() from dplyr package
d <- filter(D, Date == "1/2/2007" | Date == "2/2/2007")

#Create a new column 'datetime' with date and time together in the proper class, using dmy_hms() from lubridate
d <- mutate(d, datetime = paste(Date,Time))
d$datetime <- dmy_hms(d$datetime)


png(file="plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))
plot(d$datetime, d$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(d$datetime, d$Global_active_power)

plot(d$datetime, d$Voltage, type="n", ylab="Voltage", xlab="datetime")
lines(d$datetime, d$Voltage)

plot(d$datetime, d$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(d$datetime, d$Sub_metering_1, col="black")
lines(d$datetime, d$Sub_metering_2, col="red")
lines(d$datetime, d$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), bty="n")

plot(d$datetime, d$Global_reactive_power, type="l", ylab="Global_Reactive_Power", xlab="datetime", lwd=1)
#lines(d$datetime, d$Global_active_power)

dev.off()


# restore locale
Sys.setlocale("LC_ALL", my_locale)
