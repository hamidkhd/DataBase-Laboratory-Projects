from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$match": 
                        {"sendTime": {"$gte": "2021-12-14T00:00:00Z", "$lte": "2021-12-1T23:59:59Z"}}},
                    {"$unwind": 
                        {"path": "$hashtags", "preserveNullAndEmptyArrays": false}},
                    {"$group": 
                        {"_id": "$hashtags", "count": {"$sum": 1}}},
                    {"$sort": 
                        {"count": -1}},
                    {"$limit": 10}
                    ])