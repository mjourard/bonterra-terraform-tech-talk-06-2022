#!/usr/bin/env bash

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
echo "Loading the .env file in this directory..."
export $(grep -v '^#' .env | xargs)
if [ -z "$PROJECT" ]; then
    echo "No PROJECT environment variable detected. exiting..."
    exit 1
fi
if [ -z "$ENVIRONMENT" ]; then
    echo "No ENVIRONMENT environment variable detected. exiting..."
    exit 1
fi
if [ -z "$AWS_DEFAULT_REGION" ]; then
    echo "No AWS_DEFAULT_REGION environment variable detected. exiting..."
    exit 1
fi

STACK_NAME=terraform-state-management-$PROJECT-$ENVIRONMENT
echo "Querying stack $STACK_NAME for Terraform state management infrastructure..."
BUCKET=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs[?OutputKey=='StatesBucket'].OutputValue" --output text)
DYNAMO=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs[?OutputKey=='StateLocksDynamo'].OutputValue" --output text)
echo "Initializing Terraform..."
pushd $DIR/tf
terraform init \
  -input=false \
  -backend-config="bucket=$BUCKET" \
  -backend-config="key=$PROJECT.tfstate" \
  -backend-config="region=$AWS_DEFAULT_REGION" \
  -backend-config="dynamodb_table=$DYNAMO" \
  -backend-config="encrypt=true"

popd