# Install necessary packages
#install.packages("dplyr")
#install.packages("ggplot2")

# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")

######################################################################################################################
#### Identify the top 5 counties that has a upward trend of Amebiasis disease 
#### regardless of gender Between 2001 - 2014
######################################################################################################################

# Filter the data to exclude California
filtered_data <- data %>%
  filter(County != "California")

# Aggregate data by County and Year
amebiasis_agg <- filtered_data %>%
  group_by(County, Year) %>%
  summarize(total_count = sum(Count, na.rm = TRUE))

# Identify the top five counties with the highest total counts over the period
top_counties <- amebiasis_agg %>%
  group_by(County) %>%
  summarize(total_count_sum = sum(total_count, na.rm = TRUE)) %>%
  arrange(desc(total_count_sum)) %>%
  slice(1:5) %>%
  pull(County)

# Filter the data for these top five counties
top_counties_data <- amebiasis_agg %>%
  filter(County %in% top_counties)

# Define colors for the top counties, with the highest being black
county_colors <- c("black", "red", "blue", "green", "purple")
names(county_colors) <- top_counties

# Plot the trends for each of these counties
ggplot(top_counties_data, aes(x = Year, y = total_count, color = County)) +
  geom_line(size = 1) +
  scale_color_manual(values = county_colors) +
  labs(title = "Trend of Amebiasis Disease in Top Five Counties (2001-2014)",
       x = "Year",
       y = "Total Count of Amebiasis Cases",
       color = "County") +
  theme_minimal()

############################################################################################
#### Identify the county that had the most 
#### upward trend of Amebiasis disease regardless of gender
############################################################################################

# Calculate the trend increase for each county
trend_analysis <- amebiasis_agg %>%
  group_by(County) %>%
  summarize(start_count = first(total_count),
            end_count = last(total_count),
            increase = end_count - start_count) %>%
  arrange(desc(increase))

upward_trend_county <- trend_analysis$County[1]

# Print the county with the upward trend
print(upward_trend_county) # It should be Los Angeles

# Filter the aggregated data for the top county
top_county_data <- filtered_data %>%
  filter(County == upward_trend_county)

# Aggregate the data by Year and Sex for the top county
top_county_sex_agg <- top_county_data %>%
  group_by(Year, Sex) %>%
  summarize(total_count = sum(Count, na.rm = TRUE))

# Plot the trends for Total, Female, and Male in the top county
ggplot(top_county_sex_agg, aes(x = Year, y = total_count, color = Sex)) +
  geom_line(size = 1) +
  labs(title = paste("Trend of Amebiasis Disease in", upward_trend_county, "(2001-2014)"),
       x = "Year",
       y = "Total Count of Amebiasis Cases",
       color = "Sex") +
  scale_color_manual(values = c("Total" = "black", "Female" = "red", "Male" = "blue")) +
  theme_minimal()
