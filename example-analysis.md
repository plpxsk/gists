An example analysis, which follows [my project template](https://github.com/pavopax/new-project-template).

From a real analysis. Some data redacted.

# Makefile

makefile contains the recipe to run the entire analysis.

Eg, to rerun the whole thing, just type `make all` and press ENTER.


```
all: clean data process pool

clean:
	rm -rf cache derived

.PHONY: data
data:
	mkdir -p data/...
	Rscript code/get_data_from_bce.R

process:
	mkdir -p cache/...
	Rscript code/process_study1.R
	Rscript code/process_study2.R
	Rscript code/process_study3.R

pool:
	mkdir -p derived/adam
	echo "analysis.csv consists of only analysis-ready variables from the ADAM datasets (it includes a subset of the variables from the ADAM datasets, all in a single dataset for analysis)" > derived/README.md
	Rscript code/pool.R

adhoc:
	Rscript code/obtain_prior_cancer_treatment.R

specs:
	# [this copies some files to /data]
	scp ..

local:    # this is to copy server data to local, for quicker development
	mkdir -p data/...
	scp -r ...

tweak:
	git commit -m 'Tweak'; git push
```


# directories

```
/cache
/code
/data
/derived
/notebooks
/output
/references
```

important directories are `/code` (ETL, data munging),  `/notebooks` (data summaries and results), and `/derived` for analysis datasets


# /code
```
get_data_from_*.R
make_specs_from_sas_files.sas
obtain_prior_*.R
pool.R
process_*.R
process_*.R
process_*.R

helpers.R
README.md
```


# /notebooks

```
checks.Rmd
checks.md
checks_cache
data-report.Rmd
predictive-prognostic.Rmd
predictive-prognostic.html
predictive-prognostic.md
predictive-prognostic_files
summary-full.Rmd
summary-full.md
summary.Rmd
summary.html
summary.md
t*-comparison.Rmd
t*-comparison.md
validation.Rmd
validation.html
validation.md

README.md
```
