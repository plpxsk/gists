suppressPackageStartupMessages(library(tidyverse))


PROB <- 0.004
SELECTED_PRED_PROB <- .7
N <- 5e4

df <- tibble(
    y=rbernoulli(N, PROB) %>% as.numeric(),
    rand=rbernoulli(N, SELECTED_PRED_PROB) %>% as.numeric()
    ) %>%
    mutate(
        truth=y %>% as.factor(),
        pred_bin=y*rand,
        pred=pred_bin*.8
    )

y_sum <- df %>% pull(y) %>% sum()
pred_sum <- df %>% pull(pred_bin) %>% sum()

r <- yardstick::roc_auc(df, truth, pred, estimator="binary",
                        event_level="second")
r <- r %>% pull(".estimate")

message("Samples: ", N)
message("Y's: ", y_sum)
message("Preds (binary): ", pred_sum)
message("ROC: ", r)



