from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$unwind": 
                        {"path": "$hashtags", "preserveNullAndEmptyArrays": false}},
                    {"$group": 
                        {"_id": "$hashtags", "max": {"$sum": 1}}},
                    {"$sort": 
                        {"max": -1}},
                    {"$limit": 1}
                    ])

db.tweets.aggregate([{"$unwind": 
                        {"path": "$hashtags", "preserveNullAndEmptyArrays": false}},
                    {"$group": 
                        {"_id": "$hashtags", "min": {"$sum": 1}}},
                    {"$sort": 
                        {"min": 1}},
                    {"$limit": 1}
                    ])
