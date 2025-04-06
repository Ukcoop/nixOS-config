#!/bin/sh

day=$(date '+%d')
month=$(date '+%B')
year=$(date '+%Y')

# Remove leading zero from the day if present
day_no_leading_zero=$(echo "$day" | sed 's/^0//')

# Determine the ordinal suffix
if [[ $day_no_leading_zero -eq 1 || $day_no_leading_zero -eq 21 || $day_no_leading_zero -eq 31 ]]; then
    suffix="st"
elif [[ $day_no_leading_zero -eq 2 || $day_no_leading_zero -eq 22 ]]; then
    suffix="nd"
elif [[ $day_no_leading_zero -eq 3 || $day_no_leading_zero -eq 23 ]]; then
    suffix="rd"
else
    suffix="th"
fi

# Combine the parts
formatted_date="${day_no_leading_zero}${suffix} of ${month}, ${year}"

echo "$formatted_date"
