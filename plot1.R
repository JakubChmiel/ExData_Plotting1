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

## subsetting data
hpc <- hpc[hpc$Date %in% c(as.Date('2007-02-01'),as.Date('2007-02-02')),]

## generating plot

hist(hpc$Global_active_power,col='red',xlab = 'Global Active Power (kilowatts)',ylab='Frequency'
     , main = 'Global Active Power',  breaks = 12)

## saving generated plot to PNG file

dev.copy(png,file = 'plot1.png')
dev.off()