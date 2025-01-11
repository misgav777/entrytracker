#!/bin/bash

# Fetch secrets from AWS Secrets Manager
SECRET_NAME="mysecret"
REGION_NAME="ap-south-1"

# Get the secret value
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION_NAME --query SecretString --output text)

# Parse the secret value and export as environment variables
export MYSQL_ROOT_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')
export MYSQL_DATABASE=$(echo $SECRET_VALUE | jq -r '.dbname')

# Echo the values to check if they are correct
# echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
# echo "MYSQL_DATABASE: $MYSQL_DATABASE"