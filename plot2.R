# Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data frame by Baltimore data
baltimore <- subset(NEI, fips == "24510")

# Total tons of emissions per year
baltimoreTotal <- with(baltimore, tapply(Emissions, year, sum, na.rm = TRUE))

# Vector of years for plotting purposes
years <- c("1999", "2002", "2005", "2008")

# Set up graphics device to plot to a png file device
png("plot2.png", height = 480, width = 480, units = "px")

# Make plot 2 (Total tons of PM 2.5 Emmissions in Baltimore per year) using R Base Plotting
plot(years, baltimoreTotal, type = "n", xlab = "Year", ylab = "Tons of PM 2.5 Emissions", main = "Total Tons of PM 2.5 Emissions (Baltimore) Per Year")
points(years, baltimoreTotal)

# Turn off graphics device
dev.off()