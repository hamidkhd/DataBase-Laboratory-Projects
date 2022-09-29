from pymongo import MongoClient

client = MongoClient()
db = client.sahamyab


db.tweets.aggregate([{"$group": 
                        {"_id": "$senderUsername", "total": {"$sum": 1}}},
                        {"$group": 
                            {"_id": 
                                {"$switch": 
                                    {"branches": [
                                            { "case": { "$eq": [ "$total", 1 ] },
                                                        "then": "OneTweet" },
                                                    
                                            { "case": { "$and": [ { "$gt" : [ "$total", 1 ] }, { "$lte" : [ "$total", 3 ] } ] }, 
                                                        "then": "TwoOrThreeTweet" },
                                            
                                            { "case": { "$gt": [ "$total", 3 ] }, 
                                                        "then": "MoreThanThreeTweet" }
                                            
                                                    ], "default": "ZeroTweet"
                        }},  "numUsers": {"$sum": 1}}}])