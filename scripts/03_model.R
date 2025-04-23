# summary statistics and visualization 
library(docopt)
library(tidyverse)
library(readr)
library(tidymodels)
"this script splits the data, defines and fits the model
Usage: scripts/03_model.R --input_data=<input_data> --train=<train> --test=<test> --model=<model> 
"-> doc

opt <- docopt(doc)

data <- read_csv(opt$input_data) %>%
        mutate(species = as.factor(species))

# Split data
set.seed(123)
data_split <- initial_split(data, strata = species)
train_data <- training(data_split)
test_data <- testing(data_split)

write_csv(train_data, opt$train)
write_csv(test_data, opt$test)

# Define model
penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
    set_engine("kknn")


# Create workflow
penguin_workflow <- workflow() %>%
    add_model(penguin_model) %>%
    add_formula(species ~ .)


# Fit model
penguin_fit <- penguin_workflow %>%
    fit(data = train_data)

saveRDS(penguin_fit, opt$model)



# Rscript scripts/03_model.R --input_data=data/prep_penguins.csv --train=data/train.csv --test=data/test.csv --model=results/model/knn_penguin.RDS

