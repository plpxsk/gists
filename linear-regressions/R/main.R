suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(broom))
suppressPackageStartupMessages(library(glmnet))

PRINT_SUMMARIES <- TRUE

df <- read_csv("data/df.csv", col_types=list())
df <- df %>% select(-split)

print("RUNNING MODEL: glm")
mod <- glm(y~., data=df, family="binomial")

if (PRINT_SUMMARIES) {
    print(mod %>% summary())
}

r1 <- mod %>%
    tidy() %>%
    select(feature=term, coef=estimate) %>%
    mutate(kind="R-glm") %>%
    select(kind, feature, coef)


print("RUNNING MODEL: glmnet")
X = as.matrix(df %>% select(-y))
y = df %>% pull(y)
mod <- cv.glmnet(X, y, alpha=0) #alpha=0 -> ridge

r2 <- mod %>%
    coef(s = "lambda.min") %>%
    ## :sad_face:
    ## tidy()
    as.matrix() %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    as_tibble() %>%
    set_names(c('feature', 'coef')) %>%
    mutate(kind="R-glmnet") %>%
    select(kind, feature, coef)

result <- bind_rows(r1, r2)
write_csv(result, "results/R.csv")
