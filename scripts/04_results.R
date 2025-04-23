library(docopt)
library(tidyverse)
library(readr)
library(tidymodels)

"
this script predicts results on test data and creates a confusion matrix 
Usage: scripts/04_results.R --input_data=<input_data> --model=<model> --preds=<preds> --conf_matrix=<conf_matrix>
" -> doc

opt <- docopt(doc)

# Read data and model
test_data <- read_csv(opt$input_data)
penguin_fit <- readRDS(opt$model)

# Predict
predicted_classes <- predict(penguin_fit, test_data, type = "class")
predictions <- bind_cols(predicted_classes, test_data)

# Inspect structure before creating results tibble
cat("\nStructure of predictions:\n")
print(str(predictions))

# Create results tibble with renamed factor columns
results <- tibble(
    truth = factor(predictions$species),
    estimate = factor(predictions$.pred_class)
)

# Inspect results tibble structure
cat("\nStructure of results tibble:\n")
print(str(results))

# Confusion matrix
conf_matrix <- conf_mat(results, truth = truth, estimate = estimate)

# Save outputs
write_csv(predictions, opt$preds)
write_csv(as_tibble(conf_matrix$table), opt$conf_matrix)

# Rscript scripts/04_results.R --input_data=data/test.csv --model=results/model/knn_penguin.RDS --preds=results/tables/predictions.csv --conf_matrix=results/tables/confusion_matrix.csv


