# Makefile 
# author: Emma Wolfe 

# example usage:
# make all

.PHONY: all dats figs clean-dats clean-figs clean-all

# run entire analysis
all: tut-6.html

penguins.csv : 01_load_data.R data
	Rscript scripts/01_load_data.R --output=data/penguins.csv