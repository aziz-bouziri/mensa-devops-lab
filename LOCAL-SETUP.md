# 🏠 Local Development Setup Guide

## Prerequisites Installation

### 1. Docker Desktop
```bash
# macOS with Homebrew
brew install --cask docker

# Or download from: https://www.docker.com/products/docker-desktop
# Verify installation
docker --version
docker-compose --version
```

### 2. Kubernetes (kubectl)
```bash
# macOS with Homebrew
brew install kubectl

# Verify installation
kubectl version --client
```

### 3. Helm
```bash
# macOS with Homebrew
brew install helm

# Verify installation
helm version
```

### 4. Additional Tools
```bash
# Git (if not already installed)
brew install git

# Optional: k9s for better Kubernetes management
brew install k9s

# Optional: kubectx for context switching
brew install kubectx
```

## Local Kubernetes Setup

### Option 1: Docker Desktop Kubernetes
1. Open Docker Desktop
2. Go to Settings → Kubernetes
3. Enable "Enable Kubernetes"
4. Click "Apply & Restart"

### Option 2: Minikube
```bash
# Install minikube
brew install minikube

# Start minikube
minikube start --driver=docker

# Verify
kubectl cluster-info
```

### Option 3: Kind (Kubernetes in Docker)
```bash
# Install kind
brew install kind

# Create cluster
kind create cluster --name devops-lab

# Set context
kubectl cluster-info --context kind-devops-lab
```

## Project Setup

### 1. Clone and Setup Repository
```bash
# Clone the repository
git clone https://github.com/aziz-bouziri/mensa-devops-lab.git
cd mensa-devops-lab

# Make scripts executable
chmod +x scripts/*.sh

# Pull required Docker images
./scripts/pre-exam-setup.sh
```

### 2. Create Local Namespace
```bash
# Create namespace for local development
kubectl create namespace mensa-local

# Set as default namespace (optional)
kubectl config set-context --current --namespace=mensa-local
```

### 3. Build Local Images
```bash
# Build server image
cd docker/server
docker build -t mensa-server:local .

# Build client image
cd ../client
docker build -t mensa-client:local .

# Go back to root
cd ../..
```

## Local Development Workflows

### Docker Compose Development
```bash
# Start all services locally
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose up --build -d
```

### Kubernetes Development
```bash
# Deploy to local Kubernetes
kubectl apply -f k8s/

# Check deployment status
kubectl get pods -n mensa-local

# Port forward to access services
kubectl port-forward service/mensa-service 8080:80 -n mensa-local

# View logs
kubectl logs -f deployment/mensa-deployment -n mensa-local
```

### Helm Development
```bash
# Install using Helm (development values)
helm install mensa-app helm/ -f helm/values-dev.yaml -n mensa-local

# Upgrade deployment
helm upgrade mensa-app helm/ -f helm/values-dev.yaml -n mensa-local

# Uninstall
helm uninstall mensa-app -n mensa-local

# Debug template rendering
helm template mensa-app helm/ -f helm/values-dev.yaml
```

## Development Environment Configuration

### Environment Variables
Create a `.env` file in the project root:
```bash
# Database configuration
POSTGRES_DB=mensa_local
POSTGRES_USER=admin
POSTGRES_PASSWORD=localpassword
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# Application configuration
APP_ENV=development
LOG_LEVEL=debug
PORT=8080
```

### Local Values Override
Create `helm/values-local.yaml`:
```yaml
# Local development overrides
replicaCount: 1

image:
  repository: mensa-server
  tag: local
  pullPolicy: Never

service:
  type: NodePort
  port: 8080

ingress:
  enabled: false

resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi

postgresql:
  enabled: true
  auth:
    username: admin
    password: localpassword
    database: mensa_local
```

## Useful Local Development Commands

### Docker Commands
```bash
# Build all images
docker-compose build

# View running containers
docker ps

# Clean up unused images
docker image prune -f

# View container logs
docker logs <container-name>

# Execute into container
docker exec -it <container-name> /bin/bash
```

### Kubernetes Commands
```bash
# Get all resources in namespace
kubectl get all -n mensa-local

# Describe pod for debugging
kubectl describe pod <pod-name> -n mensa-local

# Port forward database
kubectl port-forward service/postgres 5432:5432 -n mensa-local

# Execute into pod
kubectl exec -it <pod-name> -n mensa-local -- /bin/bash

# View events
kubectl get events -n mensa-local --sort-by='.lastTimestamp'
```

### Helm Commands
```bash
# List releases
helm list -n mensa-local

# Get values from release
helm get values mensa-app -n mensa-local

# Rollback to previous version
helm rollback mensa-app 1 -n mensa-local

# Test templates
helm lint helm/
```

## Troubleshooting

### Common Issues

1. **Docker not running**
   ```bash
   # Start Docker Desktop or restart Docker service
   sudo systemctl start docker  # Linux
   open -a Docker  # macOS
   ```

2. **Kubernetes cluster not accessible**
   ```bash
   # Check cluster status
   kubectl cluster-info
   
   # Reset context
   kubectl config use-context docker-desktop
   ```

3. **Images not found**
   ```bash
   # For local images, ensure pullPolicy is Never or IfNotPresent
   # Check if images exist locally
   docker images | grep mensa
   ```

4. **Port conflicts**
   ```bash
   # Find what's using the port
   lsof -i :8080
   
   # Kill process using port
   kill -9 <PID>
   ```

### Debugging Steps
1. Check Docker Desktop is running
2. Verify Kubernetes cluster is active: `kubectl get nodes`
3. Ensure namespace exists: `kubectl get namespaces`
4. Check pod status: `kubectl get pods -n mensa-local`
5. View pod logs: `kubectl logs <pod-name> -n mensa-local`
6. Describe failed pods: `kubectl describe pod <pod-name> -n mensa-local`

## IDE Setup

### VS Code Extensions
- Docker
- Kubernetes
- Helm Intellisense
- YAML
- GitLens

### IntelliJ IDEA Plugins
- Docker
- Kubernetes
- Helm
- YAML/Ansible Support

## Quick Start Script
Create this as `scripts/local-setup.sh`:
```bash
#!/bin/bash
echo "🏠 Setting up local development environment..."

# Create namespace
kubectl create namespace mensa-local --dry-run=client -o yaml | kubectl apply -f -

# Build images
docker-compose build

# Deploy with Helm
helm upgrade --install mensa-app helm/ -f helm/values-local.yaml -n mensa-local

echo "✅ Local setup complete!"
echo "🌐 Access the application:"
echo "   kubectl port-forward service/mensa-service 8080:80 -n mensa-local"
echo "   Then open: http://localhost:8080"
```

This guide provides everything you need for local development and testing before your exam!
