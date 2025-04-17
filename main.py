from fastapi import FastAPI
import sqlite3
from typing import List
from pydantic import BaseModel

app = FastAPI()

# Define the response model
class Recommendation(BaseModel):
    Hotel_ID: int
    Channel_ID: int
    Score: float

# Database fetch function
def fetch_recommendations() -> List[Recommendation]:
    conn = sqlite3.connect("hotel_recommendations.db")
    cursor = conn.cursor()
    cursor.execute("SELECT Hotel_ID, Channel_ID, Score FROM recommendations")
    rows = cursor.fetchall()
    conn.close()

    return [Recommendation(Hotel_ID=row[0], Channel_ID=row[1], Score=row[2]) for row in rows]

# API endpoint
@app.get("/recommendations", response_model=List[Recommendation])
def get_recommendations():
    return fetch_recommendations()


@app.get("/recommendations/{hotel_id}", response_model=List[Recommendation])
def get_recommendations_for_hotel(hotel_id: int):
    conn = sqlite3.connect("hotel_recommendations.db")
    cursor = conn.cursor()
    cursor.execute(
        "SELECT Hotel_ID, Channel_ID, Score FROM recommendations WHERE Hotel_ID = ?",
        (hotel_id,)
    )
    rows = cursor.fetchall()
    conn.close()
    return [Recommendation(Hotel_ID=row[0], Channel_ID=row[1], Score=row[2]) for row in rows]




#uvicorn main:app --host 0.0.0.0 --port 8000
#ngrok http 8000