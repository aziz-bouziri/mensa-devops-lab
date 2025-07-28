#!/bin/bash

# Quick deployment script for exam scenarios

set -e

echo "🚀 Starting Mensa App Deployment..."

# Build Docker images
echo "📦 Building Docker images..."
docker build -t mensa-server:latest ./docker/server
docker build -t mensa-client:latest ./docker/client

# Start with Docker Compose
echo "🐳 Starting services with Docker Compose..."
docker-compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 30

# Health checks
echo "🔍 Performing health checks..."
curl -f http://localhost:8080/actuator/health || echo "❌ Server health check failed"
curl -f http://localhost:3000 || echo "❌ Client health check failed"

echo "✅ Deployment completed!"
echo "🌐 Access the application:"
echo "   - Frontend: http://localhost:3000"
echo "   - Backend:  http://localhost:8080"
echo "   - Metrics:  http://localhost:8080/actuator/prometheus"
