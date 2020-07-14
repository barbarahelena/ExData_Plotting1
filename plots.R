## Assignment week 1 - Plots - Exploratory Data Analysis Coursera
## Barbara Verhaar, b.j.verhaar@amsterdamumc.nl

library(dplyr)

## Open file
epc <- read.table('household_power_consumption.txt', header = TRUE, sep=';')
head(epc)
epc[epc == '?'] <- NA
epc$Date <- strptime(epc$Date, "%d/%m/%Y")
epc$Time <- strptime(epc$Time, "%H:%M:%S")
epc$DateTime <- as.POSIXct(paste(epc$Date, epc$Time), format="%Y-%m-%d %H:%M:%S")
head(epc)

## Subset
epc2 <- epc %>% filter(Date=='2007-02-01'|Date=='2007-02-02') %>% 
    mutate_at(c('Global_active_power'), as.numeric)
head(epc2)

## Plot 1: hist Global Active Power
png(filename='plot1.png', width = 480, height = 480)
hist(epc2$Global_active_power, col='red', main = 'Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()

## Plot 2: line graph Global Active Power
png(filename='plot2.png', width = 480, height = 480)
plot(epc2$DateTime, epc2$Global_active_power, type='S', ylab='Global Active Power (kilowatts)', xlab = '')
dev.off()

## Plot 3: line graph Sub metering
png(filename='plot3.png', width = 480, height = 480)
plot(epc2$DateTime, epc2$Sub_metering_1, type='n', ylab='Energy sub metering', xlab = '')
lines(epc2$DateTime, epc2$Sub_metering_1)
lines(epc2$DateTime, epc2$Sub_metering_2, col='red')
lines(epc2$DateTime, epc2$Sub_metering_3, col='blue')
legend('topright', lty=c(1,1,1), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'))
dev.off()

## Plot 2: line graph Global Active Power
png(filename='plot4.png', width = 480, height = 480)
par(mfrow=c(2,2))
plot(epc2$DateTime, epc2$Global_active_power, type='S', ylab='Global Active Power (kilowatts)', xlab = '')
plot(epc2$DateTime, epc2$Voltage, type='S', ylab='Voltage', xlab = 'datetime')
plot(epc2$DateTime, epc2$Sub_metering_1, type='n', ylab='Energy sub metering', xlab = '')
lines(epc2$DateTime, epc2$Sub_metering_1)
lines(epc2$DateTime, epc2$Sub_metering_2, col='red')
lines(epc2$DateTime, epc2$Sub_metering_3, col='blue')
legend('topright', lty=c(1,1,1), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), bty='n')
plot(epc2$DateTime, epc2$Global_reactive_power, type='S', ylab='Global_reactive_power', xlab = 'datetime')
dev.off()


