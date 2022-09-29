from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$match": 
                        {"sendTime": {"$gte": "2021-12-16T00:00:00Z", "$lte": "2021-12-16T23:59:59Z"}}},
                    {"$group": 
                        {"_id": "$senderUsername", "count": {"$sum": 1}, "senderName": { "$first": "$senderName"},
                        "senderuserName": { "$last": "$senderUsername"}}},
                    {"$sort": 
                        {"count": -1}},
                    {"$limit": 1}
                    ])