names_to_lower <- function(.data) {
    .data %>% set_names(., tolower(names(.)))
}

names_to_upper <- function(.data) {
    .data %>% set_names(., toupper(names(.)))
}

## requires library(testthat)
expect_unique_rows <- function(.data, id="USUBJID") {
    expect_equal(nrow(.data), length(unique(.data[[id]])))
}

get_file_from_path  <- function(path, file, suppress_coltype_msg=TRUE) {
    if (suppress_coltype_msg)
        paste0(path, file) %>% read_csv(col_types=cols())
    }
    else {
        paste0(path, file) %>% read_csv()
    }
}

char_to_factor <- . %>% mutate_if(is.character, as.factor)
