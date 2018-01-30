names_to_lower <- function(.data) {
    .data %>% set_names(., tolower(names(.)))
}

names_to_upper <- function(.data) {
    .data %>% set_names(., toupper(names(.)))
}

## requires library(testthat)
expect_unique_rows <- function(.data, id="id_col") {
    expect_equal(nrow(.data), length(unique(.data[[id]])))
}

get_file_from_path  <- function(path, file, suppress_coltype_msg=TRUE) {
    if (suppress_coltype_msg) {
        paste0(path, file) %>% read_csv(col_types=cols())
    } else {
        paste0(path, file) %>% read_csv()
    }
}

## to preview all your variables: data %>% char_to_factor %>% summary
char_to_factor <- function(.data) {
    .data %>% mutate_if(is.character, as.factor)
}

## I take pieces of this as needed
make_valid_colnames <- function(colnames) {
    colnames %>%
        make.names(unique=TRUE) %>%
        gsub("\\.", "_", .) %>%
        gsub("__", "_", .)  %>%   # sometimes get duplicate separators
        gsub("X_", "", .)         # some get X_ prefix
}
