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




data_v1 <- data[test,]
data$Date_time <-paste(data$Date,data$Time)
data$Date_time <- strptime(data$Date_time,"%d/%m/%Y %H:%M:%S") #class POSIXlt
# remove Date and Time
data<-data[,-which(names(data) %in% c("Date","Time")),drop=FALSE]


