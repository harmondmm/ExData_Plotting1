#Peer-graded Assignment: Course Project 1

#Loading the data

#When loading the dataset into R, please consider the following:

#The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate 
#of how much memory the dataset will require in memory before reading into R. 
#Make sure your computer has enough memory (most modern computers should be fine).

#We will only be using data from the dates 2007-02-01 and 2007-02-02. One 
#alternative is to read the data from just those dates rather than reading 
#in the entire dataset and subsetting to those dates.

#You may find it useful to convert the Date and Time variables to Date/Time 
#classes in R using the strptime() and as.Date() functions.



setwd("~/Documents/Coursera/JHUDSS/Course-ExploratoryDataAnalysis/Week1/EDA_CourseProject1")


##############################################################################################
#Install packages and libraries
##############################################################################################
install.packages("data.table")
library(data.table)
install.packages("dplyr")
library("dplyr")


##############################################################################################
#Download course project data
##############################################################################################
projectdata <- "exdata_data_household_power_consumption.zip"

# Checking if archieve exists.
if (!file.exists(projectdata)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, projectdata, method="curl")
}  

# Checking if folder exists
if (!file.exists("household_power_consumption.txt")) { 
  unzip(projectdata) 
}


##############################################################################################
#Load data into R
#Note that in this dataset missing values are coded as ?.
##############################################################################################
hpcDT <- data.table::fread("household_power_consumption.txt",
                           na.strings = "?")

# Create Date/Time variable
hpcDT[, DateTime := strptime(paste(Date, Time), format ="%d/%m/%Y %H:%M:%S")]

# Change Date Column to Date Type
hpcDT[, Date := as.Date(hpcDT$Date, format ="%d/%m/%Y")]

#Filter Dates (2880 obs of 9 variables)
hpcDT <- hpcDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("plot3.png", width = 480, height = 480)

## Create Plot 3
plot(x = hpcDT[, DateTime], 
     y = hpcDT[, Sub_metering_1],
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

#Color lines
lines(hpcDT[, DateTime], 
      hpcDT[, Sub_metering_2],
      col="red")
lines(hpcDT[, DateTime], 
      hpcDT[, Sub_metering_3],
      col="green")

#Create legend
legend("topright",
       border = "black",
       col = c("black", "red", "green"),
       c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       lty = c(1,1),
       lwd = c(1,1))

dev.off()
