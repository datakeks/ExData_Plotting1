##-------------------------------------------------------------------------------------------------
## plot3.R
## datakeks - Exploratory Data Analysis - Project 1

## Note: Background is set in the code to be transparent to match the examples in Peng's original 
## GitHub "figure" repo. The plots on the Coursera and GitHub webpages are transparent plots
## displayed on white web pages so please do not mark off for that. It actually takes extra code
## to make the plot come out transparent (line 30) instead of the default.
##-------------------------------------------------------------------------------------------------

############ Downloading the input files
setwd("./ExData_Plotting1")
if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "data/project1.zip",method = "curl")
unzip("data/project1.zip", exdir = "./data")

############ Read in the data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ';', quote= "\"", na.strings = "?", nrows = 2075259,
                   comment.char = "", stringsAsFactor = FALSE)

############ Convert the Date and Time variables to Date/Time classes in R
data$DateTime <- strptime(paste(data$Date, data$Time),"%d/%m/%Y %H:%M:%S")
data$Date <- strptime(data$Date, format = "%d/%m/%Y")

############ Subsetting by the given date range
subdata <- data[with(data, Date >= "2007-02-01" & Date <= "2007-02-02"), ]

############ Open the PNG device
png(file = "plot3.png", width = 480, height = 480, bg = "transparent")

############ Create Plot 3
with(subdata, plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(subset(subdata), lines(subdata$DateTime, subdata$Sub_metering_2, col = "red"))
with(subset(subdata), lines(subdata$DateTime, subdata$Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

############ Close the PNG device
dev.off()

############ Remove the data directory that houses the input files
unlink("data", recursive = TRUE)