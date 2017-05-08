# Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC_data <- readRDS("Source_Classification_Code.rds")

# Find all SCC codes that relate to Fuel Combustion and Coal
SCC_sub <- SCC_data[grep("^(Fuel Comb)+ (.*)+ Coal", SCC_data$EI.Sector),]
SCC_Coal <- SCC_sub$SCC

# Subset NEI data by apporpriate SCC codes
NEICoal <- subset(NEI, SCC %in% SCC_Coal)

# Calculate the sum of emissions by year
totalEmissions <- with(NEICoal, tapply(Emissions, year, sum, na.rm = TRUE))

# Vector of years for plotting purposes
years <- c(1999, 2002, 2005, 2008)

# Set up graphics device to plot to a png file device
png("plot4.png", height = 480, width = 480, units = "px")

# Make plot 4 (Coal Combustion Emissions Over the Years) using ggplot2
plot(years, totalEmissions, type = "n", xlab = "Year", ylab = "Tons of PM2.5 Emissions", main = "Total Coal Combustion Related Emissions")
points(years, totalEmissions)

# Turn off graphics device
dev.off()