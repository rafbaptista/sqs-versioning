#!/bin/bash

dotnet publish src/Producer/Producer.sln -c Release -o ./artifacts/publish
cd infra
terraform init
terraform apply -auto-approve
cd ..
rm -rf ./artifacts
echo "Deployment completed"