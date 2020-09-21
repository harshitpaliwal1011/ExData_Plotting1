library(dplyr)

#read the data in R
big_household <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)

#subset the data for only 2 days
household_power_cons_2_day <- subset(big_household, Date == "1/2/2007" | Date == "2/2/2007")

#convert the classes to be plot from character to numeric and in time and date formats
household_power_cons_2_day <- mutate(household_power_cons_2_day, 
                                     Date = as.Date(Date, format = "%d/%m/%Y"), 
                                     Time = strptime(Time, format = "%H:%M:%S"),
                                     Sub_metering_1 = as.numeric(Sub_metering_1), 
                                     Sub_metering_2 = as.numeric(Sub_metering_2),
                                     Sub_metering_3 = as.numeric(Sub_metering_3))

#edit the time format to add dates
household_power_cons_2_day[1:1440, "Time"] <- format(household_power_cons_2_day[1:1440, "Time"], "2007-02-01 %H:%M:%S")
household_power_cons_2_day[1440:2880, "Time"] <- format(household_power_cons_2_day[1440:2880, "Time"], "2007-02-02 %H:%M:%S")

#open a png graphics device
png("plot3.png")

#plot the graph
plot(household_power_cons_2_day$Time, household_power_cons_2_day$Sub_metering_1, type = "l", col = "black", xlab = "",    #add first sub metering
     ylab = "Energy sub metering", main = "Enery sub metering vs Time")
lines(household_power_cons_2_day$Time, household_power_cons_2_day$Sub_metering_2, col = "red")
lines(household_power_cons_2_day$Time, household_power_cons_2_day$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close the png graphics device
dev.off()