all: clean data process

clean:
	rm -rf data
	rm -rf data.tar
	rm -rf data.tar.gz

data:   clean
	scp user@unix:/file/location/data.tar.gz .
	gunzip data.tar.gz
	tar -xvf data.tar

process:
	mkdir -p code/logs
	Rscript code/process.R

load:
	python app.py

tweak:
	git commit -m 'Tweak'
	git push
