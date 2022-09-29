import requests
import time
from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab

url = "https://www.sahamyab.com/guest/twiter/list?v=0.1"
delay = 60

while db.tweets.count_documents({}) < 500:
    response = requests.request('GET', url, headers={'User-Agent': 'Chrome/61'})
    if response.status_code == requests.codes.ok:
        items = response.json()['items']
        for item in items:
            db.tweets.insert_one(item)
        
    print(db.tweets.count_documents({}))
    time.sleep(delay)