path <- getwd()
if(!file.exists(path)) {
  dir.create(path)
}

# Check to see if the zip file is there. If it is then don't download it.
hpfFile <- file.path(path, "household_power_consumption.zip")
if(!file.exists(hpfFile)) {
  # Url at which the data set is located
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  # Download zip file
  download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
}

# Read data set after unzipping the data file
powerConsumption <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";")
# Household power consumption for Feb. 1 and 2, 2007 only
ValidData <- powerConsumption[as.character(powerConsumption$Date) %in% c("1/2/2007", "2/2/2007"),]
# Concatante Date and Time variables
ValidData$dateTime = paste(ValidData$Date, ValidData$Time)

# Convert to Date/Time class
ValidData$dateTime <- strptime(ValidData$dateTime, "%d/%m/%Y %H:%M:%S")
attach(ValidData)

png("plot1.png", width=480, height=480, units="px")
# Plot the distribution of global active power
hist(as.numeric(as.character(Global_active_power)), col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()