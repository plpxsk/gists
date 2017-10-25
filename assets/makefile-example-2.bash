all: clean data process pool load

clean:
	rm -rf cache derived

.PHONY: data
data:
	mkdir -p data/a1 data/a2
	Rscript code/scrape_data.R

process:
	mkdir -p cache code/logs
	Rscript code/process_a1.R
	Rscript code/process_a2.R

pool:
	mkdir -p derived
	echo "cats or dogs?" > derived/README.md
	Rscript code/pool.R

load:
	@echo "Run this from server only!"
	Rscript code/load.R

adhoc:
	Rscript code/run_adhoc_report.R

tweak:
	git commit -m 'Tweak'; git push
