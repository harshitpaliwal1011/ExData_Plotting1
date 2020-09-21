library(dplyr)

#read the data in R
big_household <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)

#subset the data for only 2 days
household_power_cons_2_day <- subset(big_household, Date == "1/2/2007" | Date == "2/2/2007")

#convert the classes to be plot from character to numeric
household_power_cons_2_day <- mutate(household_power_cons_2_day,
                                     Global_active_power = as.numeric(Global_active_power))

#open a png graphics device
png(filename = "plot1.png")

#plot the graph
hist(household_power_cons_2_day$Global_active_power, xlab = "Global Active Power(kilowatts)", col="red", main = "Global Active Power")

#close the png graphics device
dev.off()