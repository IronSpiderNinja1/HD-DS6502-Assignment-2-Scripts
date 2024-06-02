# Load the dataset
setwd("[insert path to data file here]")
data <- read.csv("Infectious Disease 2001-2014.csv")

# Subset the data for Dengue disease in San Diego and San Francisco
dengue_data_sd <- subset(data, Disease == "Dengue" & County == "San Diego")
dengue_data_sf <- subset(data, Disease == "Dengue" & County == "San Francisco")

# Check the number of samples in each set
num_samples_sd <- length(dengue_data_sd$Rate)
num_samples_sf <- length(dengue_data_sf$Rate)

# Determine if the samples are paired
paired <- FALSE
if (num_samples_sd == num_samples_sf) {
  paired <- TRUE
}

# Perform appropriate statistical test (e.g., t-test for independent samples or paired t-test for paired samples)
if (paired) {
  # Paired t-test
  result <- t.test(dengue_data_sd$Rate, dengue_data_sf$Rate, paired = TRUE)
} else {
  # Independent samples t-test
  result <- t.test(dengue_data_sd$Rate, dengue_data_sf$Rate)
}

# Print the result
print(result)
