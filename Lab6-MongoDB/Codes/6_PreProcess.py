from pymongo import MongoClient
import time
import re


client = MongoClient()

db = client.sahamyab
db_collection = db.tweets

start_time = time.time()

for record in db_collection.find():
    hashtags = list(re.findall(r"#(\w+)", record['content']))
    filter = { 'id': record['id'] }
    value = { "$set": { 'hashtags': hashtags } }
    db_collection.update_one(filter, value)
    
end_time = time.time()

print("Time: ", end_time - start_time, " s")    