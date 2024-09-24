# main.py
from fastapi import FastAPI
from typing import Optional
import uvicorn
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}

@app.get("/items/{item_id}")

def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}

if __name__ == "__main__":
    app.run(host='0.0.0.0')