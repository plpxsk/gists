# What is nested cross-validation (for) and why you should use it

In machine learning, cross-validation is always the answer. But what are the
questions?

There are at least two questions, and knowing the distinction will help you
toward correct inference in your machine learning tasks.

The two questions are:

1. How do I select the best hyperparameters?
1. What performance can I expect to observe in a new, independent dataset?

For both, the answer is "cross-validation". But two questions require **two
separate applications of cross-validation**. This is nested cross-validation.

# The alternative

If you don't use nested cross-validation, you probably use a single train-test
split:

1. The training dataset (say, 80% of your dataset) serves as both training and
   "validation". You apply cross-validation to select ("tune") hyperparameters.
1. Then, you evaluate the chosen model on the testing dataset (the remaining
   20%) to estimate the generalization performance. This happens exactly once
   (since you have one testing dataset). Note: the "model" means the algorithm
   plus the hyperparameters selected in (1).

Nested cross-validation just replaces (2) with K-fold CV to generate multiple
testing datasets, for a more reliable estimate of generalization performance.

# Nested cross-validation example

Given:

  * Classification problem with accuracy as evaluation metric
  * N = 900 example instances

Nested CV:

1. Split the full N = 900 dataset 3-fold to obtain *three different
   training/testing sets* of N = 600 and N = 300 examples.
    1. N = 600: Take one of the N = 600 datasets and use 5-fold
       cross-validation to select the best hyperparameters, with Grid or Random
       Search, for example
    2. N = 300: Evaluate the accuracy of the selected model on the testing
       dataset.
1. Repeat for each of the three different train/test sets
    1. Now, you have 3 estimates of accuracy, for each of the 3 testing
       datasets.

Therefore, nested cross-validation consists of 2 applications of
cross-validation:

  * **Outer loop: for estimating generalization performance**
      * Split the full dataset into a few training/testing sets
      * Above, 3-fold CV
  * **Inner loop: for selecting hyperparameters**
      * Use each training fold and split it a few times
      * Above, 5-fold CV
    

# Why

The bottom line is that performance metrics from a hyperparameter search
**should not be used** to estimate generalization performance. This is the
mistake to look for (Cawley and Talbot).

The mistake is that this set of cross-validation biases the model to the
dataset, "yielding an overly-optimistic score" (`scikit-learn` docs).

Instead, you should evaluate the selected model (algorithm + best
hyperparameters) on an independent holdout dataset in order to estimate the
performance (e.g., accuracy) that you expect to see in new, unseen data.

Often, this happens on the (single) test set. The idea of nested
cross-validation is to do this a few times, to obtain a more reliable estimate
of generalization performance (along with a kind of confidence level).

# Notes

### Traditional cross-validation in statistics

Traditionally, cross-validation is a statistical technique "to assess how the
results of a statistical analysis will generalize to an independent dataset"
(Wikipedia).

### Parameters vs. hyperparameters

This application of cross-validation is straightforward for traditional
statistical models which do not have tunable *hyperparameters*, but only have
model *parameters* learned from data, such as the beta coefficients learned
using maximum likelihood methods in (non-regularized) linear regression models.

However, with the advent of machine learning came new algorithms that implement
tunable *hyperparameters* that are not learned from data, but are selected
before model fitting. These hyperparameters are usually part of the
regularization/penalty process (for example `C` in Support Vector Machines, or
`alpha/lambda` in regularized regression (L1/Lasso, or L2/Ridge)).

These hyperparameters are not learned from the data, but must be selected
before "training".

### A second use of cross-validation in machine learning

And this **second task** was also given to cross-validation, so that it now has
two uses:

1. Selecting hyperparameters ("newer" usage)
1. Estimating generalization performance ("traditional/statistical" usage)

It seems that in the beginning of machine learning, the primary (or explicit)
usage of cross-validation was actually for the first, newer case.

In most python `scikit-learn` examples (`scikit-learn` being the
bread-and-butter tool for machine learning), you see usage of
`train_test_split()` to create a *single* testing or holdout dataset to
estimate generalization performance (ie, *not* using K-fold
cross-validation*). Instead, (K-fold) cross-validation is only used for tuning
hyperparameters.

_*Note: you could say that a single train-test split also constitutes
"cross-validation" with a single 2-fold split, so that the above could also be
a simple case of "nested"
cross-validation. [scikit-learn/pull/618](https://github.com/scikit-learn/scikit-learn/pull/618/files#diff-4b44173e050d6a693b27ae2028635d91)._

# References

Cawley, G.C.; Talbot, N.L.C. On over-fitting in model selection and subsequent
selection bias in performance evaluation. J. Mach. Learn. Res 2010,11,
2079-2107.

Cross-validation
(Statistics). [Wikipedia](https://en.wikipedia.org/wiki/Cross-validation_(statistics)).

Nested versus non-nested cross-validation. [python scikit-learn
docs](https://scikit-learn.org/stable/auto_examples/model_selection/plot_nested_cross_validation_iris.html).

A couple relevant Stack-Exchange posts: [Nested cross validation for model
selection](https://stats.stackexchange.com/q/65128/207989) and [CV for model
parameter tuning AND then model
evaluation](https://stats.stackexchange.com/q/133120/207989).


