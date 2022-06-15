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
STACK_NAME=terraform-state-management-$PROJECT-$ENVIRONMENT
echo "Creating stack $STACK_NAME"
aws cloudformation deploy --template-file $DIR/aws-backend.yml --stack-name $STACK_NAME --parameter-overrides Project=$PROJECT Environment=$ENVIRONMENT
echo "Stack created...querying"
aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[].Outputs[].OutputValue'
