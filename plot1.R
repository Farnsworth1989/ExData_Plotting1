## Script to produce plot 1
## Assumes that raw data file "household_power_consumption.txt" is stored in the working 
## directory and will save the plot as a png file into the working directory

## import full data table
full_data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
                      na.strings = "?")

## format first column into date format
full_data$Date<-as.Date(strptime(full_data$Date,format="%d/%m/%Y"))

## subset the data to the two dates of interest
cut_data<-subset(full_data,as.Date("2007-02-01")<=Date & Date<=as.Date("2007-02-02"))

## format the second column to be the date and time (also brings the date into this column)
cut_data$Time<-as.POSIXct(strptime(paste(cut_data$Date,cut_data$Time),
                                   format="%Y-%m-%d %H:%M:%S"))

## open the png file device (note that width and height default to 480 pixels)
png(filename="plot1.png")
## sets the plot format to be 1x1 (just in case it is not in the default)
par(mfrow=c(1,1))

## create the required plot
hist(cut_data$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",col="red")

## close the file device
dev.off()

## the plot should now be saved correctly as "plot1.png"