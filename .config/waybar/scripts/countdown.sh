#!/bin/sh

# Get the current date
current_date=$(date +%s)

# Get the target date (May 3, 2025)
target_date=$(date -d "2025-05-03" +%s)

# Calculate the difference in seconds
difference=$((target_date - current_date))

# Calculate the number of weeks and days
weeks=$((difference / (7 * 24 * 3600)))
days=$((difference / (24 * 3600)))

# Output the result
echo "W: $weeks, D: $days"
