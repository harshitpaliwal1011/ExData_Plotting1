library(dplyr)

#read the data in R
big_household <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)

#subset the data for only 2 days
household_power_cons_2_day <- subset(big_household, Date == "1/2/2007" | Date == "2/2/2007")

#convert the classes to be plot from character to numeric and in time and date formats
household_power_cons_2_day <- mutate(household_power_cons_2_day, 
                                     Date = as.Date(Date, format = "%d/%m/%Y"), 
                                     Time = strptime(Time, format = "%H:%M:%S"),
                                     Global_active_power = as.numeric(Global_active_power))

#edit the time format to add dates
household_power_cons_2_day[1:1440, "Time"] <- format(household_power_cons_2_day[1:1440, "Time"], "2007-02-01 %H:%M:%S")
household_power_cons_2_day[1440:2880, "Time"] <- format(household_power_cons_2_day[1440:2880, "Time"], "2007-02-02 %H:%M:%S")

#open a png graphics device
png(filename = "plot2.png")

#plot the graph
plot(household_power_cons_2_day$Time, 
     household_power_cons_2_day$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", 
     main = "Global Active Power vs Time")

#close the png graphics device
dev.off()