#-------------------------------------------------------------------
# EXPLORATORY DATA ANALYSIS - COURSE PROJECT 1 
#-------------------------------------------------------------------
#The overall goal here is simply to examine how household energy usage 
#varies over a 2-day period in February, 2007, and the task is to reconstruct 
#the Plot 4.
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
#creating plot4.png file
png("plot4.png")
#making plot 4
par(mfrow = c(2, 2))
plot(complete_date, power_cons$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(complete_date, power_cons$Voltage, type = "l", xlab = "dataframe", ylab = "Voltage")
plot(complete_date, power_cons$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(complete_date, power_cons$Sub_metering_2, type = "l", col = "red")
points(complete_date, power_cons$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(complete_date, power_cons$Global_reactive_power, type = "l", xlab = "dataframe", ylab = "Global_reactive_power")
#closing graphic device
dev.off()
