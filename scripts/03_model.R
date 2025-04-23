# summary statistics and visualization 

"this script splits the data, defines and fits the model, predicts results and creates a confusion matrix 
example: scripts/03_model.R --input_data=<data> --train=<train> --test=<test> --model=<model> --preds=<preds> --conf_matrix=<conf_matrix>
"-> doc

opt <- docopt(doc)

data <- read_csv(opt$data)

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
```
saveRDS(penguin_model, opt$model)

# Results

We evaluate the performance of the model using the test dataset.

```{r}
# Predict on test data
predictions <- predict(penguin_fit, test_data, type = "class") %>%
    bind_cols(test_data)

write_csv(predictions, opt$preds)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

write_csv(conf_mat, opt$conf_matrix)

# Rscripts/03_model.R --input_data=data/prep_penguins.csv --train=data/train.csv --test=data/test.csv --model=results/model/knn_penguin.RDS --preds=results/tables/predictions.csv --conf_matrix=<results/tables/conf_matrix.csv>
