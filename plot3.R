# load ggplot2 library
library(ggplot2)

# Read in PM2.5 data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data frame by Baltimore data
baltimore <- subset(NEI, fips == "24510")

transform(baltimore, type = factor(type))

years <- c(1999, 2002, 2005, 2008)

## Find yearly totals per year by type
# non-road
nonRoad <- subset(baltimore, type == "NON-ROAD")
nonRoadTotal <- with(nonRoad, tapply(Emissions, year, sum, na.rm = TRUE))
dfNonR <- data.frame(years,nonRoadTotal)
dfNonR$type <- rep("NON-ROAD", length(nonRoadTotal))
names(dfNonR) <- c("year", "emissions", "type")

#non-point
nonPoint <- subset(baltimore, type == "NONPOINT")
nonPointTotal <- with(nonPoint, tapply(Emissions, year, sum, na.rm = TRUE))
dfNonP <- data.frame(years,nonPointTotal)
dfNonP$type <- rep("NONPOINT", length(nonPointTotal))
names(dfNonP) <- c("year", "emissions", "type")

# on-road
onRoad <- subset(baltimore, type == "ON-ROAD")
onRoadTotal <- with(onRoad, tapply(Emissions, year, sum, na.rm = TRUE))
dfOnR <- data.frame(years,onRoadTotal)
dfOnR$type <- rep("ON-ROAD", length(onRoadTotal))
names(dfOnR) <- c("year", "emissions", "type")

# point
point <- subset(baltimore, type == "POINT")
pointTotal <- with(point, tapply(Emissions, year, sum, na.rm = TRUE))
dfOnP <- data.frame(years, pointTotal)
dfOnP$type <- rep("POINT", length(pointTotal))
names(dfOnP) <- c("year", "emissions", "type")

dfTotals <- rbind(dfNonP, dfNonR, dfOnP, dfOnR)
rownames(dfTotals) <- 1:nrow(dfTotals)

# Construct ggplot2 object
g <- ggplot(dfTotals, aes(year, emissions))

# Set up graphics device to plot to a png file device
png("plot3.png")

# Make plot 3 (Total tons of PM 2.5 Emmissions in Baltimore per year) using R Base Plotting
g + geom_point() + facet_wrap(~ type) + geom_smooth(method = "lm") + labs(title = "Total PM2.5 Emissions by Measurement Type Baltimore")

# Turn off graphics device
dev.off()