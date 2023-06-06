## set working directory to txt file and install necessary packages

setwd("household_power_consumption.txt")

install.packages(c("dplyr", "lubridate", "data.table", "ggplot2", "tidyr", "stringr"))

## create Plot 1 function

  dataFile <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

  ## Format date to Type Date
  dataFile$Date <- as.Date(dataFile$Date, "%d/%m/%Y")

  ## Filter data set from 2/1/2007 to 2/2/2007
  dataFile <- subset(dataFile,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

  ## Remove incomplete observation
  dataFile <- dataFile[complete.cases(dataFile),]
  
  ## Combine Date and Time column
  dateTime <- paste(dataFile$Date, dataFile$Time)
  
  ## Name the vector
  dateTime <- setNames(dateTime, "DateTime")
  
  ## Remove Date and Time column
  dataFile <- dataFile[ ,!(names(dataFile) %in% c("Date","Time"))]
  
  ## Add DateTime column
  dataFile <- cbind(dateTime, dataFile)

## plot "global active power" histogram for subset dates
  
  hist(dataFile$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
  dev.off()
