import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    months = ['01','02','03','04','05','06','07','08','09','10','11','12']

    data_frames = []
    for month in months:
        # parse_dates = ['tpep_pickup_datetime', 'tpep_dropoff_datetime']
        url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{month}.parquet"

        data = pd.read_parquet(url)

        data_frames.append(data) 
    df=pd.concat(data_frames)

    #df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime, unit='ns')
    #df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime, unit='ns')

    print(df.dtypes)
 
    return df

# @test
# def test_output(output, *args) -> None:
#     """
#     Template code for testing the output of the block.
#     """
#     assert output is not None, 'The output is undefined'