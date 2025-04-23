# loads the data and drops NaN 


library(tidyverse)
library(palmerpenguins)
library(tidymodels)

"this script loads the penguin data and cleans it by dropping nans
example: scripts/01_clean_data.R --output=data/penguins.csv
"-> doc

opt <- docopt(doc)

# Initial cleaning: Remove missing values
data <- penguins %>% drop_na()

write_csv(data, opt$output)

# Rscript scripts/01_clean_data.R --output=data/penguins.csv