# Style/workflow tips for programming in R

Just some thoughts from my experience which aim to amplify existing guides.


# Workflow

For more complicated/larger analyses, try to work with R scripts instead of long Rmd documents
- consider limiting an Rmd document to a quick summary with a few plots, or some one-off analysis
- rationale:
    - large Rmd files, especially if written by <= 1 human, can be unwieldy to manage by others, or by the author in the future
    - splitting one large file into more reusable pieces will make your code more reusable


# Style - good practices
I hesitate to call these "best" until I am more certain that others agree.

## Rmd documents

are not overly long (a few hundred lines max)

put libraries on top, not throughout

add contact/email at top in case others find it in the wild and/or are interested in the code


## R scripts

should run with zero (minimal) messages/warnings
- use `suppressPackageStartupMessages(library(tidyverse))`
    - in joining, use explicit `by` variables
  
