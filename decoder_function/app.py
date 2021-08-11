import json
import requests
from PIL import Image
from pylibdmtx.pylibdmtx import decode

DATAMATRIX_FILE = 'https://raw.githubusercontent.com/NaturalHistoryMuseum/pylibdmtx/master/pylibdmtx/tests/datamatrix.png'


def lambda_handler(event, context):
    datamatrix = Image.open(requests.get(
        DATAMATRIX_FILE, stream=True, allow_redirects=True).raw)
    decoded_data = decode(datamatrix)
    results = [{'content': entry.data.decode(
        'utf8'), 'rect': entry.rect} for entry in decoded_data]
    return {
        "statusCode": 200,
        "body": json.dumps(results),
    }
