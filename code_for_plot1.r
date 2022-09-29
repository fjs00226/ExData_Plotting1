# unzip data file
unzip(zipfile= "./exdata_data_household_power_consumption.zip",exdir="./raw_data")
# calculate memory: 2075259rows*9columns*8bytes = 149418648 bytes ~150 Mb
data<-read.table("./raw_data/household_power_consumption.txt",header=TRUE, sep=";")
str(data)
object.size(data) # 150050248 bytes

# convert date
data$Date<-as.Date(data$Date,"%d/%m/%Y")

# get data for 2007-02-01 and 2007-02-02
data_v1 <- rbind(data[which(data$Date == "2007-02-01"),],data[which(data$Date == "2007-02-02"),])

# Is the data complete?
grep(FALSE, complete.cases(data_v1)) # 0 complete

# change power and metering to numeric datatype
data_v1$Global_active_power<-as.numeric(data_v1$Global_active_power)
data_v1$Global_reactive_power<-as.numeric(data_v1$Global_reactive_power)
data_v1$Sub_metering_1<-as.numeric(data_v1$Sub_metering_1)
data_v1$Sub_metering_2<-as.numeric(data_v1$Sub_metering_2)
data_v1$Sub_metering_3<-as.numeric(data_v1$Sub_metering_3)

# get time
data_v1$Date_time <-paste(data_v1$Date,data_v1$Time)
data_v1$Date_time <- strptime(data_v1$Date_time,"%Y-%m-%d %H:%M:%S") #class POSIXlt

# view data frame
str(data_v1)

# making plot1, save as png
png(file="./plot1.png", width=480, height=480)
hist(data_v1$Global_active_power,main="Global Active Power", xlab="Global Active Power(kilowatts)",ylab="Frequency",col="red")
dev.off()