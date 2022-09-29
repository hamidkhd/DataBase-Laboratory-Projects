import redis
import datetime

r = redis.Redis()

a = r.mset({"Croatia": "Zagreb", "Bahamas": "Nassau"})
b = r.get("Bahamas")

print(a)
print(b)

today = datetime.date.today()
visitors = {"dan", "jon", "alex"}

stoday = today.isoformat()  
print(stoday)

# c = r.sadd(today, *visitors)

c = r.sadd(stoday, *visitors)  
print(c)

d =  r.smembers(stoday)
print(d)

e = r.scard(today.isoformat())
print(e)