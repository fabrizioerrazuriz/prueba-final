import json
import boto3
import os

client = boto3.client('sns')

SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    for record in event["Records"]:
        payload = record["body"]
        payload_string = str(payload)
        print("Mensaje recibido: " + str(payload_string))
        response = client.publish(TopicArn=SNS_TOPIC_ARN,Message="Mensajes de SQS procesados con éxito: " + payload_string)
        print("Noticación enviada con éxito")
        print(f"Payload procesado: {payload_string}")
        return (response)