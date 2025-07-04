# summary statistics and visualization 
library(docopt)
library(tidyverse)
library(readr)
"this script calculates summary statistics, creates a visualization and prepares the data for the model
Usage: scripts/02_methods.R --input_data=<data> --summary=<summary> --boxplot=<boxplot> --prep_data=<prep_data>
"-> doc

opt <- docopt(doc)

data <- read_csv(opt$input_data)

# glimpse at data 
glimpse <- glimpse(data)

# summary statistics 
summary_stats <- summarise(data, 
                           mean_bill_length = mean(bill_length_mm), 
                           mean_bill_depth = mean(bill_depth_mm))

write_csv(summary_stats, opt$summary)

# Visualizations
boxplot_image <- ggplot(data, aes(x = species, y = bill_length_mm, fill = species)) +
    geom_boxplot() +
    theme_minimal()

ggsave(opt$boxplot, boxplot_image)

# Prepare data for modeling
data <- data %>%
    select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
    mutate(species = as.factor(species))

write_csv(data, opt$prep_data)

# Rscript script/02_methods.R --input_data=data/penguins.csv --summary=results/tables/summary_stats.csv --boxplot=results/figures/boxplot.png --prep_data=data/prep_penguins.csv

