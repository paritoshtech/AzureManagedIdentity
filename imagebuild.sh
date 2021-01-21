#!/bin/bash

export SHA=$(git rev-parse HEAD)

# eval $(minikube docker-env)

ACR_NAME=DTLPacr

az acr build --registry $ACR_NAME -t datachain/backend-api:${SHA} -t datachain/backend-api:latest \
   -f ../dockerfiles/app-native/Dockerfile \
   ../../


# echo "Setting the image to $SHA"
# kubectl set image deployments/datachain-backend -n datachain-backend datachain-backend=dtlpacr.azurecr.io/datachain/backend-api:${SHA}

#To prevent pushing the images to registry and then pull them for usage.

# export SHA=$(git rev-parse HEAD)
# eval $(minikube docker-env)

docker build -t datachain/backend-api:latest \
   -f ../dockerfiles/app-native/Dockerfile \
   ../../

kubectl rollout restart deploy deployments/datachain-backend -n datachain-backend

docker build -t datachain/backend-nginx:${SHA} -t datachain/backend-nginx:latest \
   -f ../dockerfiles/nginx/Dockerfile \
   ../../backend

echo "Done"

# az acr build --registry $ACR_NAME -t datachain/backend-nginx:${SHA} -t datachain/backend-nginx:latest \
#    -f ../dockerfiles/nginx/Dockerfile \
#    ../../backend

# kubectl set image deployments/datachain-backend datachain-backend=dtlpacr.azurecr.io/datachain/backend-api:${SHA}

# Image full name
# dtlpacr.azurecr.io/datachain/backend-api:5efb0c52e72dd7ce7e374ae9e21c10e0b7d065ea

# kubectl run -it  test-backend --image=dtlpacr.azurecr.io/datachain/backend-api:5efb0c52e72dd7ce7e374ae9e21c10e0b7d065ea --env="NODE_ENV=staging"

# kubectl get deploy deploymentname -o yaml --export
