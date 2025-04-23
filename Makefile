# Makefile 
# author: Emma Wolfe 

# example usage:
# make all

.PHONY: all dats figs clean-dats clean-figs clean-all

# run entire analysis
all: tut-6.html

# loads the data 
penguins.csv : scripts/01_load_data.R data
	Rscript scripts/01_load_data.R \
		--output=data/penguins.csv

# methods 

summary_stats.csv prep_penguins.csv : scripts/02_methods.R 
	Rscript script/02_methods.R 
		--input_data=data/penguins.csv 
		--summary=results/tables/summary_stats.csv 
		--boxplot=results/figures/boxplot.png --prep_data=data/prep_penguins.csv

# model 
train.csv test.csv knn_penguins.RDS : scripts/03_model.R
	Rscript scripts/03_model.R 
		--input_data=data/prep_penguins.csv 
		--train=data/train.csv 
		--test=data/test.csv 
		--model=results/model/knn_penguin.RDS 
		
# results
predictions.csv confusion_matrix.csv : scripts/03_model.R
	Rscript scripts/03_model.R 
	--input_data=data/test.csv 
	--preds=results/predictions.csv 
	--conf_matrix=results/tables/confusion_matrix.csv
