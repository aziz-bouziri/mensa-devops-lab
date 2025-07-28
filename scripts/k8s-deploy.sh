#!/bin/bash

# Kubernetes deployment script with namespace support

set -e

# Configuration
NAMESPACE=${1:-mensa}
CONTEXT=${2:-$(kubectl config current-context)}

echo "☸️  Deploying to Kubernetes..."
echo "📍 Target namespace: $NAMESPACE"
echo "🔧 Using context: $CONTEXT"

# Create namespace if it doesn't exist
echo "🏗️  Creating namespace if needed..."
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Apply all Kubernetes manifests to the specified namespace
echo "📦 Applying manifests to namespace: $NAMESPACE"
kubectl apply -f k8s/ -n $NAMESPACE

echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/mensa-server -n $NAMESPACE

# Port forward for local access
echo "🔌 Setting up port forwarding..."
kubectl port-forward svc/mensa-server-svc 8080:80 -n $NAMESPACE &

echo "✅ Kubernetes deployment completed!"
echo "🌐 Access via: http://localhost:8080"
echo "📍 Deployed to namespace: $NAMESPACE"

# Show pod status
echo "📊 Current pod status:"
kubectl get pods -l app=mensa-server -n $NAMESPACE

echo ""
echo "🛠️  Useful commands:"
echo "   kubectl get all -n $NAMESPACE"
echo "   kubectl logs deployment/mensa-server -n $NAMESPACE"
echo "   kubectl delete namespace $NAMESPACE  # Cleanup"
