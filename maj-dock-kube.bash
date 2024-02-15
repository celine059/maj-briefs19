#!/bin/bash

# Définir les variables
CONTAINER_NAME="customweb-briefs19"
DOCKERHUB_USERNAME="celine059"
DOCKER_IMAGE="customweb"
DOCKER_TAG="latest"
KUBE_DEPLOYMENT="deploy-customweb"
KUBE_NAMESPACE="briefs-simplon"

# Construire une nouvelle image Docker
docker build -t $DOCKER_IMAGE:$DOCKER_TAG .

# Authentification à Docker Hub
docker login -u $DOCKERHUB_USERNAME

# Pousser la nouvelle image vers Docker Hub
docker push $DOCKERHUB_USERNAME/$DOCKER_IMAGE:$DOCKER_TAG

# Mettre à jour le déploiement dans Kubernetes
kubectl set image deployment/$KUBE_DEPLOYMENT $CONTAINER_NAME=$DOCKERHUB_USERNAME/$DOCKER_IMAGE:$DOCKER_TAG -n $KUBE_NAMESPACE
