#!/bin/bash

# Fetch secrets from AWS Secrets Manager
SECRET_NAME="mysecret"
REGION_NAME="ap-south-1"

# Get the secret value
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION_NAME --query SecretString --output text)

# Parse the secret value and export as environment variables
export DB_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')
export DB_NAME=$(echo $SECRET_VALUE | jq -r '.dbname')

echo the values to check if they are correct
echo $DB_PASSWORD
echo $DB_NAME