from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.find({"sendTime": {"$gte": "2021-12-14T21:14:00Z", "$lte": "2021-12-14T21:29:00Z"}}, {"senderUsername": 1, "type": 1, "_id": 0})