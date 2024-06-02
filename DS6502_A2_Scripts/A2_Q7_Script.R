# Install necessary packages
#install.packages("dplyr")

# Load necessary libraries
library(dplyr)

# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")


################################################################################
#### Question 7(a)
################################################################################

# Subset the data for Cryptosporidiosis in California, Lake, San Diego, and San Francisco
cryptosporidiosis_data <- subset(data, Disease == "Cryptosporidiosis" &
                                   County %in% c("California", 
                                                 "Lake", 
                                                 "San Diego", 
                                                 "San Francisco"))

# Perform ANOVA test
result <- aov(Rate ~ County, data = cryptosporidiosis_data)

# Print the result
print(summary(result))

################################################################################
#### Question 7(b)
################################################################################

# Perform Tukey's HSD test for pairwise comparisons
tukey_result <- TukeyHSD(result)

# Print the results
print(tukey_result)

################################################################################
#### Question 7(c)
################################################################################

# Create a line plot
ggplot(cryptosporidiosis_data, aes(x = County, y = Rate, group = County, color = County)) +
  geom_line() +
  geom_point() +
  labs(title = "Rate of Cryptosporidiosis in California, Lake, San Diego, and San Francisco",
       x = "County", y = "Rate") +
  theme_minimal()

