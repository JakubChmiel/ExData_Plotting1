## reading sampled data. Data starts with 16/12/2006. Every day is 1440 minutes. 
## Our sample start after approximetly 66000 rows. 
## I will take 4000 rows to be sure that all nedeed data is considered, and filter data afterwords
hpc <- read.table('household_power_consumption.txt',sep=';',header = F, nrows = 4000, skip = 66000)

## reading in data colnames
hpcColnames <- read.table('household_power_consumption.txt',sep=';',header = F, nrows = 1)
## setting data colnames
for (i in 1:ncol(hpc)) {
  colnames(hpc)[i] <- as.character(hpcColnames[,i])
}

## converting types of date and datetime fields

hpc$Date <- as.Date(hpc$Date)
hpc$datetime <- strptime(paste(hpc$Date,hpc$Time), "%Y-%m-%d %H:%M:%S")



## saving and generating plot
png(file = 'plot3.png',width = 480, height = 480)

with(hpc,plot(datetime,Sub_metering_1,type='l',xlab = '', ylab = 'Energy sub metering' ) )
with(hpc,lines(datetime,Sub_metering_2, col = 'red'))
with(hpc,lines(datetime,Sub_metering_3, col = 'blue'))
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col = c('black','red','blue'), lty = 1)

dev.off()
