import json
import boto3
import os
from PIL import Image
import io
import uuid
from urllib.parse import unquote_plus

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

# Environment variables
TABLE_NAME = os.environ.get('TABLE_NAME')
PROCESSED_BUCKET = os.environ.get('PROCESSED_BUCKET')

table = dynamodb.Table(TABLE_NAME)


def lambda_handler(event, context):
    """
    Lambda entry point
    Processes images uploaded to S3 via SQS event trigger
    """

    print("EVENT:", json.dumps(event))

    if 'Records' not in event:
        print("Invalid event format")
        return

    for record in event['Records']:
        try:
            body = json.loads(record.get('body', '{}'))

            if 'Records' not in body:
                print("Invalid SQS body:", body)
                continue

            s3_record = body['Records'][0]

            bucket = s3_record['s3']['bucket']['name']

            key = unquote_plus(s3_record['s3']['object']['key'])

            print(f"Processing file: {key}")

            response = s3.get_object(Bucket=bucket, Key=key)
            image_content = response['Body'].read()

            try:
                image = Image.open(io.BytesIO(image_content))
            except Exception as e:
                print(f"Unsupported or corrupt image: {key}, error: {str(e)}")
                continue

            print("IMAGE MODE BEFORE:", image.mode)

            image = image.convert("RGB")

            print("IMAGE MODE AFTER:", image.mode)

            image.thumbnail((200, 200))
        
            buffer = io.BytesIO()
            image.save(buffer, format="JPEG")

            new_key = f"processed/{uuid.uuid4()}.jpg"

            s3.put_object(
                Bucket=PROCESSED_BUCKET,
                Key=new_key,
                Body=buffer.getvalue(),
                ContentType='image/jpeg'
            )

            print(f"Image uploaded to processed bucket: {new_key}")

            print("Writing to DynamoDB...")

            table.put_item(
                Item={
                    "image_id": str(uuid.uuid4()),
                    "original_key": key,
                    "processed_key": new_key
                }
            )

            print("DynamoDB write SUCCESS")
            print(f"SUCCESS: {key}")

        except Exception as e:
            print(f"ERROR processing {key}: {str(e)}")
            raise e