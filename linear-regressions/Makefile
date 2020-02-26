all: data run

clean:
	rm -rf data results

data:
	mkdir -p data
	python py/generate_data.py


run:
	mkdir -p results 
	python py/main.py > results/py.log
	Rscript R/main.R > results/R.log

