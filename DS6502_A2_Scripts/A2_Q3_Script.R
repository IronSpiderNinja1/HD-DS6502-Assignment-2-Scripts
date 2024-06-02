# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")

# Filter for the year 2010
data_2010 <- subset(data, Year == 2010)

# Filter for Malaria and exclude California
malaria_data <- subset(data_2010, Disease == "Malaria" & County != "California")

# Filter for counties with at least 10 infected cases
malaria_county_10 <- subset(malaria_data, Count >= 10)

# Remove duplicate counties
unique_counties <- unique(malaria_county_10$County)

# Print the unique counties
print(unique_counties)
