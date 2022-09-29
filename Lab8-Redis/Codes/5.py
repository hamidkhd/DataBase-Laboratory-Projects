import redis
import json

import warnings
warnings.filterwarnings("ignore")

restaurant_484272 = {
    "name": "Ravagh",
    "type": "Persian",
    "address": {
        "street": {
            "line1": "11 E 30th St",
            "line2": "APT 1",
        },
        "city": "New York",
        "state": "NY",
        "zip": 10016,
    }
}

r = redis.Redis(db=3)

print(r.set(484272, json.dumps(restaurant_484272)))



from pprint import pprint
pprint(json.loads(r.get(484272)))


import yaml  
print(yaml.dump(restaurant_484272))