# XGBoost with nested cross-validation

Install requirements:

	pip install -r requirements.txt

Run code script:

	python main.py


# Explaining models

There are different philosophies and methods.

Some ideas to get started:

  * Explain the final model from `gcv.fit(X, y)` (see code)
  * And/or summarize explanations from _all_ models via `cross_validate(..., return_estimator=True)`
  * Compare explanations of XGB to other models

# References

In this repo: [What is nested cross-validation (for)](https://github.com/pavopax/gists/blob/master/nested-cross-validation.md)
 
From Prof. Sebastian Raschka: [Code Notebooks](https://github.com/rasbt/stat479-machine-learning-fs19/tree/78552507095b1b42bd7a1e63dd08649068110923/11_eval4-algo/code)

See scikit-learn docs: [Code Example](https://scikit-learn.org/stable/auto_examples/model_selection/plot_nested_cross_validation_iris.html)
