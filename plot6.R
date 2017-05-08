# Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

# Find all SCC codes that relate to Fuel Combustion and Coal
SCC_sub <- SCC_data[grep("^(Mobile)+ (.*)+ Vehicles", SCC_data$EI.Sector),]
SCC_Motor <- SCC_sub$SCC

# Subset NEI data by apporpriate SCC codes
NEIMotor <- subset(NEI, SCC %in% SCC_Motor)
#transform(NEIMotor, type = factor(type))

# Extract Baltimore City Motor Data
baltimore <- subset(NEIMotor, fips == "24510")

# Extract Los Angeles Motor Data
losAngeles <- subset(NEIMotor, fips == "06037")

# Calculate the sum of emissions by year
totalBaltimore <- with(baltimore, tapply(Emissions, year, sum, na.rm = TRUE))
totalLA <- with(losAngeles, tapply(Emissions, year, sum, na.rm = TRUE))

# Vector of years for plotting purposes
years <- c(1999, 2002, 2005, 2008)

df <- data.frame(years, totalBaltimore, totalLA)

# Set up graphics device to plot to a png file device
png("plot6.png", height = 480, width = 480, units = "px")

# Make plot 6 (Motor Vehicle Emissions Over the Years) using base
plot(years, totalLA, type = "n", xlab = "Year", ylab = "Tons of PM2.5 Emissions", main = "Total Motor Vehicle Related Emissions; Baltimore and LA", ylim = c(0, 5000))
points(years, totalBaltimore, col = "red")
points(years, totalLA, col = "blue")
legend("right", legend = c("Baltimore", "LA"), pch = 1, col = c("red", "blue"))

# Turn off graphics device
dev.off()