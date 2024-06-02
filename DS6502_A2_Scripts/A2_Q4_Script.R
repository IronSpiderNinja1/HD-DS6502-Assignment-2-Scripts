# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")


# Filter for the period of 2010 - 2012
data_2010_2012 <- subset(data, Year >= 2010 & Year <= 2012)

# Filter for Tuberculosis and exclude California
tb_data <- subset(data_2010_2012, Disease == "Tuberculosis" & County != "California")

# Filter for counties with NO infected cases for Tuberculosis
tb_no_cases_county <- subset(tb_data, Count == 0)

# Get unique counties with NO cases
no_tb_cases_counties <- unique(tb_no_cases_county$County)

# Total number of counties
total_counties <- length(unique(data$County))

# Number of counties with at least 10 cases
tb_at_least_10_count <- length(unique(subset(tb_data, Count >= 10)$County))

# Ratio of counties with at least 10 or NO cases to other counties
ratio <- (tb_at_least_10_count + length(no_tb_cases_counties)) / total_counties

# Calculate correlation between Count (infected cases) and Population
correlation <- cor(tb_data$Count, tb_data$Population)

# Print counties with NO cases of Tuberculosis:
print(no_tb_cases_counties)

# Print ratio of counties with at least 10/NO cases to other counties;
print(ratio)

# Print correlation between infected cases and population:
print(correlation)
