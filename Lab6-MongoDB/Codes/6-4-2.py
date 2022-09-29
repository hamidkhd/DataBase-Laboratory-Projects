from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$unwind": 
                        {"path": "$hashtags", "preserveNullAndEmptyArrays": false}},
                    {"$group": 
                        {"_id": "$hashtags", "total": {"$sum": 1}}},
                    {"$sort": 
                        {"total": -1}}])