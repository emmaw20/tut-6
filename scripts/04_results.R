# Predict on test data
predictions <- predict(penguin_fit, test_data, type = "class") %>%
    bind_cols(test_data)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat