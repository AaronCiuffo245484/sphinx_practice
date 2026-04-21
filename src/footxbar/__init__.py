"""footxbar — one line description of what the package does."""

from importlib.metadata import version

__version__ = version("footxbar")

from fastapi import FastAPI
from footxbar.example import show, add_one

app = FastAPI()

@app.get("/add/{number}")
def add(number: int):
    return {"result": add_one(number)}
