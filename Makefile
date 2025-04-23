# Makefile 
# author: Emma Wolfe 

# example usage:
# make all

.PHONY: all clean

# run entire analysis
all: 
	make data/penguins.csv
	make results/tables/summary_stats.csv results/figures/boxplot.png data/prep_penguins.csv
	make data/train.csv data/test.csv results/model/knn_penguin.RDS
	make results/tables/predictions.csv results/tables/confusion_matrix.csv
	make report

# loads the data 
data/penguins.csv: scripts/01_load_data.R
	Rscript scripts/01_load_data.R \
		--output=data/penguins.csv

# methods 

results/tables/summary_stats.csv results/figures/boxplot.png data/prep_penguins.csv: scripts/02_methods.R 
	Rscript scripts/02_methods.R \
		--input_data=data/penguins.csv \
		--summary=results/tables/summary_stats.csv \
		--boxplot=results/figures/boxplot.png \
		--prep_data=data/prep_penguins.csv

# model 
data/train.csv data/test.csv results/model/knn_penguins.RDS: scripts/03_model.R
	Rscript scripts/03_model.R \
		--input_data=data/prep_penguins.csv \
		--train=data/train.csv \
		--test=data/test.csv \
		--model=results/model/knn_penguin.RDS
		
# results
results/tables/predictions.csv results/tables/confusion_matrix.csv: scripts/04_results.R
	Rscript scripts/04_results.R \
		--input_data=data/test.csv \
		--model=results/model/knn_penguin.RDS \
		--preds=results/tables/predictions.csv \
		--conf_matrix=results/tables/confusion_matrix.csv

report: tut-6.qmd
	quarto render tut-6.qmd --to html --output-dir docs
	quarto render tut-6.qmd --to pdf --output-dir docs
	
clean:
	rm -f data/*.csv results/tables/*.csv results/figures/*.png results/model/*.RDS results/predictions.csv
