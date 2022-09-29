from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.updateMany({"parentId": {"$exists": true}}, {"$unset": {"type": ""}})