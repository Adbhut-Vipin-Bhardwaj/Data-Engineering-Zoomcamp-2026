import json
import time
import pandas as pd
from kafka import KafkaProducer

from models import Ride, ride_from_row, ride_serializer


server = "localhost:9092"
topic_name = "rides"
file_path = "./yellow_tripdata_2025-11.parquet"
columns = ['PULocationID', 'DOLocationID', 'trip_distance', 'total_amount', 'tpep_pickup_datetime']

df = pd.read_parquet(file_path, columns=columns).head(1000)
df.head()

producer = KafkaProducer(
    bootstrap_servers=[server],
    value_serializer=ride_serializer,
)


t0 = time.time()

for _, row in df.iterrows():
    ride = ride_from_row(row)
    producer.send(topic_name, value=ride)
    print(f"Sent: {ride}")
    time.sleep(0.01)

producer.flush()

t1 = time.time()
print(f'took {(t1 - t0):.2f} seconds')
