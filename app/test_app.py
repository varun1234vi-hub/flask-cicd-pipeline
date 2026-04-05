import pytest
import sys
import os

# Ensure the app package is on the Python path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.app import app

@pytest.fixture
def client():
    # Create a test client for the Flask app
    with app.test_client() as client:
        yield client

def test_home_route(client):
    response = client.get('/')
    assert response.status_code == 200
    assert response.json == {"message": "Hello, Flask with Prometheus!"}

def test_metrics_route(client):
    response = client.get('/metrics')
    assert response.status_code == 200
    assert b'app_request_count' in response.data
    assert b'app_request_latency_seconds' in response.data

def test_health_route(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json == {"status": "ok"}

