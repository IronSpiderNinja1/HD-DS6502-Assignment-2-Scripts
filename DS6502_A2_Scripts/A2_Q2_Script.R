# Install necessary packages
#install.packages("dplyr")

# Load necessary libraries
library(dplyr)

# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")

# Filter the dataset for the year 2005 and disease HIV and female gender
hiv_female_2005 <- data %>%
  filter(Year == 2005, Disease == "HIV", Sex == "Female")

# Identify the county with the highest rate of infected females
highest_rate_county <- hiv_female_2005 %>%
  filter(Rate == max(Rate, na.rm = TRUE)) %>%
  select(County, Rate, Population)

# Print the county with the highest rate of infected females for HIV in 2005
print(highest_rate_county)
