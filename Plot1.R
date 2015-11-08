#Please change the working directory in the line below to your directory
#containing household_power_consumption.txt

wd <- "D:/Ucheba/Data Science Specialization/04 Exploratory data analysis/Week 1/CP1"

setwd(wd)

##########################


Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
#Otherwise I get Russian name of days of the week!


#Load neccesary packages

list.of.packages <- c("dplyr", "readr")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(dplyr)
library(readr)


#Read the file
D <- read_delim("household_power_consumption.txt", delim=";", col_types = "ccnnnnnnn", na="?")

#Extract the data for 1st and 2nd Feb of 2007 using filter() from dplyr package
d <- filter(D, Date == "1/2/2007" | Date == "2/2/2007")

#plot the graph
png(file="plot1.png", width = 480, height = 480, units = "px")
hist(d$Global_active_power, col=2, main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
