# presents results 
"this script predicts results on test data and creates a confusion matrix 
example: scripts/03_model.R --input_data=<data> --preds=<preds> --conf_matrix=<conf_matrix>
"-> doc

opt <- docopt(doc)

data <- read_csv(opt$data)

# Results


# Predict on test data
predictions <- predict(penguin_fit, test_data, type = "class") %>%
    bind_cols(test_data)

write_csv(predictions, opt$preds)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

write_csv(conf_mat, opt$conf_matrix)
# Rscript scripts/03_model.R --input_data=<data> --preds=<preds> --conf_matrix=<conf_matrix>