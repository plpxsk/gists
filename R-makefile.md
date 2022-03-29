# R scripts in Makefile


Here are example ETL and report pipelines that can go in a `Makefile`:

```Make
all: data report

data:
    Rscript code/extract.R
    Rscript code/transform.R
    Rscript code/load.R

report:
    Rscript code/report.R
    Rscript code/extra_plots.R

```
