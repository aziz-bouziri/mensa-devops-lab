#!/bin/bash

# Pre-Exam Docker Images Setup Script
# This script pulls all Docker images required for the DevOps exam

echo "🚀 Starting pre-exam Docker images setup..."

# Required Docker images from exam announcement
echo "📦 Pulling required Docker images..."

# Base images for builds
echo "Pulling Gradle image..."
docker pull gradle:8.13-jdk17

echo "Pulling Java distroless images..."
docker pull gcr.io/distroless/java17-debian12

echo "Pulling Node.js images..."
docker pull node:22-alpine
docker pull gcr.io/distroless/nodejs22-debian12

echo "Pulling base OS images..."
docker pull debian:12-slim
docker pull ubuntu:24.04

echo "Pulling database images..."
docker pull postgres:17
docker pull mongo:8

echo "Pulling web server images..."
docker pull nginx:1.29
docker pull gcr.io/distroless/static-debian12

echo "Pulling Python images..."
docker pull gcr.io/distroless/python3-debian12
docker pull python:3.14

echo "Pulling utility images..."
docker pull alpine:3.22
docker pull eclipse-temurin:17-jre-noble

echo "✅ All Docker images pulled successfully!"

# Verify images are available
echo "📋 Verifying pulled images..."
docker images | grep -E "(gradle|distroless|node|debian|ubuntu|postgres|mongo|nginx|python|alpine|eclipse-temurin)"

echo ""
echo "🎯 Pre-exam setup complete!"
echo "💡 Tip: Run 'docker system df' to check disk usage"
echo "💡 Tip: These images are now cached locally for the exam"
