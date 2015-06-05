library(data.table)
library(sqldf)
data<-read.csv.sql("household_power_consumption.txt",sep=";",header=TRUE,sql="select * from file where Date in ('1/2/2007','2/2/2007')")
closeAllConnections()
datetime<-as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
newdata<-cbind(datetime,data)
finaldata<-subset(newdata,select=-c(Date,Time))
head(finaldata)

png(file="Plot4.png",width=480,height=480)
par(mfrow=c(2,2))
##plot1
plot(finaldata$datetime,finaldata$Global_active_power,type="l",xlab="",ylab="Global Active Power")
##plot2
with(finaldata,plot(datetime,Voltage,type="l"))
##plot3
with(finaldata, plot(datetime, Sub_metering_1, type = "n", xlab="",ylab="Energy sub metering"))
with(finaldata, lines(datetime, Sub_metering_1, col = "black"))
with(finaldata, lines(datetime, Sub_metering_2, col = "red"))
with(finaldata, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n")
##plot4
with(finaldata,plot(datetime,Global_reactive_power,type="l"))
dev.off()

