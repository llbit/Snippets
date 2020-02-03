# Send a POST request with JSON data.
# See https://ec.haxx.se/http/http-post
curl -d '{"model": "test"}' -H 'Content-Type: application/json' localhost:5000/api/model
