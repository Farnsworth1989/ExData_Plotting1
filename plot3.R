## Script to produce plot 3
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
png(filename="plot3.png")
## sets the plot format to be 1x1 (just in case it is not in the default)
par(mfrow=c(1,1))
## create the required plot
with(cut_data,plot(Time,Sub_metering_1,type="l",xlab="",
                   ylab="Energy sub metering"))
with(cut_data,lines(Time,Sub_metering_2,col="red"))
with(cut_data,lines(Time,Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1),col=c("black","blue","red"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## close the file device
dev.off()

## the plot should now be saved correctly as "plot3.png"