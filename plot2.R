#-------------------------------------------------------------------
# EXPLORATORY DATA ANALYSIS - COURSE PROJECT 1 
#-------------------------------------------------------------------
#The overall goal here is simply to examine how household energy usage 
#varies over a 2-day period in February, 2007, and the task is to reconstruct 
#the Plot 2.
#-------------------------------------------------------------------
# SCRIPT
#-------------------------------------------------------------------
# loading libraries
library(sqldf)
library(lubridate)

# dowloading zip file and unzipping
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "power_consumption.zip", mode = "wb")
unzip("power_consumption.zip")

# household_power_consumption.txt file which contains the data set
power_cons <- read.csv.sql("household_power_consumption.txt", sql = "Select * from file where Date in('1/2/2007', '2/2/2007')", header = T, sep = ";")
#closing sql connection
sqldf()

#changing language to English
Sys.setlocale("LC_TIME", "English")
#creating a new variable with Date and Time columns
full_date <- paste(power_cons$Date, power_cons$Time)
#changing class from chr to Date
complete_date <- strptime(full_date, "%e/%m/%Y %H:%M:%S")
#deleting temp variable
rm(full_date)
#setting png graphic device
dev.set(3)
#creating plot2.png file
png("plot2.png")
#defining margins
par(mar = c(4, 4, 2, 2))
#making plot 2
plot(complete_date, power_cons$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
#closing graphic device
dev.off()
