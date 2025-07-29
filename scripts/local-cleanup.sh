#!/bin/bash

# Local Development Cleanup Script
# This script cleans up your local development environment

echo "🧹 Cleaning up local development environment..."

# Uninstall Helm release
echo "📦 Removing Helm release..."
helm uninstall mensa-app -n mensa-local 2>/dev/null || echo "No Helm release found"

# Delete namespace (this will delete all resources in the namespace)
echo "🗑️  Deleting namespace and all resources..."
kubectl delete namespace mensa-local --ignore-not-found=true

# Remove local Docker images
echo "🐳 Removing local Docker images..."
docker rmi mensa-server:local 2>/dev/null || echo "Server image not found"
docker rmi mensa-client:local 2>/dev/null || echo "Client image not found"

# Optional: Clean up unused Docker resources
read -p "🧽 Do you want to clean up unused Docker resources? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleaning up unused Docker resources..."
    docker system prune -f
    docker volume prune -f
fi

echo ""
echo "✅ Local development environment cleanup complete!"
echo "💡 To set up again, run: ./scripts/local-setup.sh"
