import json
import re
from elasticsearch import Elasticsearch

def find_hashtags(text):
    return re.findall(r"#(\w+)", text)

es = Elasticsearch([{'host': 'localhost', 'port': 9200}])
i = 0
with open('tweets.json', encoding='UTF-8') as raw_data:
    json_docs = json.load(raw_data)
    for json_doc in json_docs:
        json_doc['hashtags'] = find_hashtags(json_doc['content'])
        i = i + 1
        es.index(index='twitter', doc_type='twitter', body=json.dumps(json_doc))
        print(i, '-->' , json_doc['hashtags'])