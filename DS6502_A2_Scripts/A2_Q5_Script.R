# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")

# Subset the data for California
ca_data <- subset(data, County == "California")

# Extract rates of Chlamydia and Salmonellosis diseases
chlamydia_rate <- ca_data$Rate[ca_data$Disease == "Chlamydia"]
salmonellosis_rate <- ca_data$Rate[ca_data$Disease == "Salmonellosis"]

# Calculate correlation coefficient
correlation <- cor(chlamydia_rate, salmonellosis_rate)

# Print rates of Chlamydia and Salmonellosis diseases
# Rates of Chlamydia
print(chlamydia_rate)
# Rates of Salmonellosis
print(salmonellosis_rate)
# Print correlation between Chlamydia and Salmonellosis rates:
print(correlation)


# Create scatter plot
plot(chlamydia_rate, salmonellosis_rate, 
     xlab = "Rate of Chlamydia", ylab = "Rate of Salmonellosis",
     main = "Scatter Plot of Chlamydia vs Salmonellosis Rates in California",
     pch = 16, col = "blue")

# Add legends
legend("topleft", legend = paste("Correlation (R) =", round(correlation, 2)), 
       bty = "n", cex = 0.8, col = "blue")

# Add grid lines
grid()
# Add regression line
abline(lm(salmonellosis_rate ~ chlamydia_rate), col = "red")

