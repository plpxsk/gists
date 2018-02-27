# Style/workflow tips for programming in R

> It is always easier to write code than it is to read it.

Just some thoughts from my experience which aim to amplify existing guides.

This is more applicable for projects that are larger than a few hundred lines of a single Rmd file.

# Workflow

For more complicated/larger analyses, try to work with R scripts instead of long Rmd documents
- consider limiting an Rmd document to a quick summary with a few plots, or some one-off analysis
- see example: look at contents of /code and /notebooks [in this repo's `example-analysis.md`](https://github.com/pavopax/gists/blob/master/example-analysis.md)
- rationale:
    - large Rmd files, especially if written by <= 1 human, can be unwieldy to manage by others, or by the author in the future
    - splitting one large file into more reusable pieces will make your code more reusable
    - smaller pieces will run faster if you only need to run a part of it
    


# Style - good practices

*I hesitate to call these "best practices" until I am more certain that a larger user base finds most of them useful.*

## General

Define functions near top of your program/script. Or in a separate `helpers.R` or similar file and then `source(“helpers.R”)` near top

Define constants near the top of the program (possibly using VARIABLES_IN_CAPS)
- you can even use separate `config.R` file with constants and other config variables that your reference throughout your project

Try to use 0/1 (or logical true, etc) binary variables instead of some more complicated strings

write out tidy CSV files - do not write row names to output CSVs. Use:
- readr::write_csv (available in tidyverse), OR:
- write.csv(..., row.names=FALSE)


When programming, consider [the rule of three](http://pavopax.github.io/2017/08/use-the-rule-of-three/)


## Rmd documents

Are not overly long (a few hundred lines max)

Place `library()` calls on top, not throughout

Add contact/email at top in case others find the analysis in the wild and/or are interested in the code

limit code lines to 79 or 80 characters max

To reuse data processing and potentially speed up knit(), put data cleaning/processing into a separate file
- for example, create and run separate R scripts (see below) that clean/process data and create "derived" datasets, and then just read in the derived data at top of your Rmd file


## R scripts


should run with zero (minimal) messages/warnings
- use `suppressPackageStartupMessages(library(tidyverse))` etc
- in joining, use explicit `by` variables
- rationale: when you run these from command line, with fewer messages, it will be easier to find real/important warnings/messages/errors. if everything is good, you will only see the "DONE" message to signify you're good to go (see next)

limit all lines to 79 or 80 characters max (for exceptions like long file paths, etc, tag the end with something line `# noqa`)
        
add `cat("DONE.\n")` to bottom to be sure when run is complete
  
