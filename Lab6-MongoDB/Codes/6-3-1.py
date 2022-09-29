from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.find({"mediaContentType": "image/jpeg", "parentId": {"$exists": true}}, {"senderName": 1, "_id": 0}).explain("executionStats")


