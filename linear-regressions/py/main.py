import pandas as pd
import statsmodels.api as sm
from sklearn.linear_model import LogisticRegression, LogisticRegressionCV

PRINT_SUMMARIES = True
KINDS = ['statsmodels', 'sklearn_lr_lbfgs', 'sklearn_lrcv']
CV = 5


def get_statsmodels_coef_as_list(X, y):
    logit = sm.Logit(y, X)
    result = logit.fit()
    if PRINT_SUMMARIES:
        print(result.summary())
    return(result.params.tolist())


def get_sklearn_coef_as_list(X, y, kind):
    if kind == 'sklearn_lr_lbfgs':
        clf = LogisticRegression(penalty='none', solver='lbfgs')
        clf.fit(X, y)
    elif kind == 'sklearn_lrcv':
        clf = LogisticRegressionCV(cv=CV, penalty='l2', solver='lbfgs')
        clf.fit(X, y)
    return(clf.coef_.flatten())


def get_coefs_from_model_as_df(kind, X, y):
    assert kind in KINDS
    if kind == 'statsmodels':
        coef_ = get_statsmodels_coef_as_list(X, y)
    elif kind == 'sklearn_lr_lbfgs':
        coef_ = get_sklearn_coef_as_list(X, y, kind)
    elif kind == 'sklearn_lrcv':
        coef_ = get_sklearn_coef_as_list(X, y, kind)

    df = dict(feature=X.columns.tolist(), coef=coef_)
    df = pd.DataFrame(df)
    df.set_index('feature', inplace=True)
    return(df)


if __name__ == '__main__':
    df = pd.read_csv("data/df.csv")

    y_column = 'y'
    y = df[y_column]
    X = df.drop(y_column, axis=1)
    # todo try models on train data only
    X = X.drop('split', axis=1)

    coefs_dfs = []
    for kind in KINDS:
        print("RUNNING MODEL : ", kind)
        coefs_dfs.append(get_coefs_from_model_as_df(kind, X, y))

    result = pd.concat(coefs_dfs, keys=KINDS, names=['kind', 'feature'])
    result = result.reset_index()
    result.to_csv("results/py.csv", index=None)
