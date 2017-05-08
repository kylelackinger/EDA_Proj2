# Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum of emissions by year
totalEmissions <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))

# Vector of years for plotting purposes
years <- c(1999, 2002, 2005, 2008)

# Set up graphics device to plot to a png file device
png("plot1.png", height = 480, width = 480, units = "px")

# Make plot 1 (Total tons of PM 2.5 Emmissions per year) using R Base Plotting
plot(years, totalEmissions, type = "n", xlab = "Year", ylab = "Tons of PM 2.5 Emissions", main = "Total Tons of PM 2.5 Emissions Per Year")
points(years, totalEmissions)

# Turn off graphics device
dev.off()
