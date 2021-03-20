from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
async def hello():
    return {"message": "Hello World"}

@app.get("/foo")
async def foo():
    return {"message": "bar"}

handler = Mangum(app)
