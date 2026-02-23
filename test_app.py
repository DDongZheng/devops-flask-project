import pytest
from app import app

@pytest.fixture
def client():
    return app.test_client()

def test_health_check(client):
    res = client.get('/')
    assert res.status_code == 200
    assert res.json['status'] == "healthy"
    