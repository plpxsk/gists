# Makefile quick start

> Makefiles are a simple way to organize code execution/compilation.

It's like a recipe for your code repo.

`Makefile` is a single file that can run all analysis code, or do other
tasks. It is self-documenting, and helps in "reproducibility."

You run this from command line.

# Hello, world!

Here's a simple example.

Make a file `Makefile` and put this in it:

```bash
all: data process output

data:
		Rscript get_datasets.R
		Rscript get_extra_files.R
	
process:
		Rscript process.R

output:
		Rscript write_plots.R
		Rscript write_tables.R
		python app.py
```

Now, from command line, you can:

  * type `make data` to run your "get data" scripts
  * type `make output` to only run your "output" script(s)
  * type `make all` to rerun the entire analysis, which consists of the pieces
    specified in the first line (`data`, `process`, `output`)

`all`, `data`, `process`, `output`, etc are called "targets"


# Advantages

Reproducibility.

Rerun the whole thing with `make all`. 

Speed: Rerun only specific pieces of your analysis with `make data`, `make process`, etc

Can be self-documenting.

# Examples

[Example 1](assets/makefile-example-1.bash)

[Example 2](assets/makefile-example-2.bash)


# Tips

Add a target `clean` to remove data and start from scratch (reproducibility!)

	clean:
		rm -rf data

If you already have a `/data` folder, then `make data` may give you
error. There are reasons for this. To alleviate this, run it as `make -B data`
or declare it as `.PHONY` in `Makefile` like:

	all: process data
	
	.PHONY: data
	data:
	    Rscript get_bce_data.R

	
More on [.PHONY](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)
