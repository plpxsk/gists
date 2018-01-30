# R snippets

Reusable code snippets that I always forget, so I put them here for me (and
you!)


# Read in many files into tibble of tibbles

```r
files <- list.files("data", pattern=".csv", full.names = TRUE)

data_frame(file=files) %>%
    mutate(data=map(file, ~read_csv(.)))
```

1. Read `/data` for `csv` files, return full names for read_csv()
1. Make data frame of filenames, and then map `read_csv(.)` to each file in
   files

  * don't forget the `(.)` in `read_csv(.)`

This returns dataframes inside a cell:

```
## # A tibble: 2 x 2
##             file                data
##            <chr>              <list>
## 1 data/file1.csv <tibble [263 x 10]>
## 2 data/file2.csv <tibble [208 x 22]>
```

See next section:


# Work with tibble of tibbles

apply a function to each dataset (see the third row):

```r
data_frame(file=files) %>% 
    mutate(data=map(file, ~read_csv(.))) %>%
    mutate(rows=map_int(data, nrow)) 
```

Returns:

```
## # A tibble: 2 x 3
##             file                data  rows
##            <chr>              <list> <int>
## 1 data/file1.csv <tibble [263 x 10]>   263
## 2 data/file2.csv <tibble [208 x 22]>   208
```
