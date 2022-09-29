from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$match": 
                        {"sendTime": {"$gte": "2021-12-15T11:30:00Z", "$lte": "2021-12-15T12:30:00Z"}}},
                    {"$group": 
                        {"_id": "$senderUsername", "total": {"$sum": 1}, "senderProfileImage": { "$first": "$senderProfileImage"}}},
                    {"$match": 
                        {"total": {"$gt": 1}}}])