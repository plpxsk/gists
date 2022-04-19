import pandas as pd
import numpy as np
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split

RANDOM_STATE = 99
TEST_SIZE = 0.2


def generate_df():

    n_samples = 200
    n_features = 10
    X, y = make_classification(n_samples=n_samples, n_features=n_features,
                               random_state=RANDOM_STATE)
    # keep y first
    yX = np.column_stack([y, X])
    columns = ['x' + str(n) for n in range(n_features)]
    columns = ['y'] + columns
    df = pd.DataFrame(yX, columns=columns)
    return(df)


def add_split_column(df):
    train, test = train_test_split(
        df, test_size=TEST_SIZE, random_state=RANDOM_STATE)

    df = pd.concat([train, test], keys=['train', 'test'],
                   names=['split', 'ix'])
    df = df.reset_index()
    df = df.drop('ix', axis=1)
    return(df)


if __name__ == '__main__':
    df = generate_df()
    df = add_split_column(df)

    p = "data/df.csv"
    df.to_csv(p, index=False)
