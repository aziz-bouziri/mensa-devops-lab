# DevOps Exam Commands Cheat Sheet

## 🐳 Docker Commands

### Build & Run
```bash
# Build image from Dockerfile
docker build -t myapp:latest .

# Build with specific Dockerfile
docker build -f docker/Dockerfile -t myapp:v1.0 .

# Run container with port mapping
docker run -d -p 8080:80 --name myapp myapp:latest

# Run container with environment variables
docker run -d -e NODE_ENV=production -e DB_HOST=localhost myapp:latest

# Run container interactively
docker run -it myapp:latest /bin/bash
```

### Container Management
```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop container
docker stop myapp

# Remove container
docker rm myapp

# View container logs
docker logs myapp

# Follow container logs
docker logs -f myapp

# Execute command in running container
docker exec -it myapp /bin/bash

# Copy files to/from container
docker cp file.txt myapp:/app/
docker cp myapp:/app/logs ./
```

### Image Management
```bash
# List images
docker images

# Remove image
docker rmi myapp:latest

# Tag image
docker tag myapp:latest registry.com/myapp:v1.0

# Push to registry
docker push registry.com/myapp:v1.0

# Pull from registry
docker pull nginx:alpine

# Remove unused images
docker image prune

# Remove all unused resources
docker system prune -a
```

## 🏗️ Docker Compose Commands

### Service Management
```bash
# Start services in background
docker-compose up -d

# Start specific service
docker-compose up -d database

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v

# View service status
docker-compose ps

# Scale service
docker-compose up -d --scale web=3

# Restart service
docker-compose restart web
```

### Logs & Debugging
```bash
# View logs for all services
docker-compose logs

# Follow logs for specific service
docker-compose logs -f web

# Execute command in service
docker-compose exec web /bin/bash

# Build services
docker-compose build

# Rebuild without cache
docker-compose build --no-cache
```

## ☸️ Kubernetes Commands

### Cluster Info
```bash
# Check cluster info
kubectl cluster-info

# Get cluster nodes
kubectl get nodes

# Describe node
kubectl describe node node-name

# Check current context
kubectl config current-context

# Switch context
kubectl config use-context my-context
```

### Namespace Management
```bash
# List namespaces
kubectl get namespaces

# Create namespace
kubectl create namespace my-namespace

# Delete namespace
kubectl delete namespace my-namespace

# Set default namespace
kubectl config set-context --current --namespace=my-namespace
```

### Resource Management
```bash
# Apply configuration
kubectl apply -f deployment.yaml

# Apply all files in directory
kubectl apply -f ./k8s/

# Apply with namespace
kubectl apply -f deployment.yaml -n production

# Delete resources
kubectl delete -f deployment.yaml

# Get all resources
kubectl get all

# Get all resources in namespace
kubectl get all -n production
```

### Pods
```bash
# List pods
kubectl get pods

# List pods with more info
kubectl get pods -o wide

# Describe pod
kubectl describe pod pod-name

# Get pod logs
kubectl logs pod-name

# Follow pod logs
kubectl logs -f pod-name

# Get logs from previous container
kubectl logs pod-name --previous

# Execute command in pod
kubectl exec -it pod-name -- /bin/bash

# Port forward to pod
kubectl port-forward pod-name 8080:80

# Copy files to/from pod
kubectl cp file.txt pod-name:/tmp/
kubectl cp pod-name:/tmp/file.txt ./
```

### Deployments
```bash
# List deployments
kubectl get deployments

# Describe deployment
kubectl describe deployment my-app

# Scale deployment
kubectl scale deployment my-app --replicas=5

# Update image
kubectl set image deployment/my-app container=new-image:tag

# Check rollout status
kubectl rollout status deployment/my-app

# View rollout history
kubectl rollout history deployment/my-app

# Rollback deployment
kubectl rollout undo deployment/my-app

# Rollback to specific revision
kubectl rollout undo deployment/my-app --to-revision=2
```

### Services
```bash
# List services
kubectl get services

# Describe service
kubectl describe service my-service

# Get service endpoints
kubectl get endpoints my-service

# Port forward to service
kubectl port-forward service/my-service 8080:80
```

### ConfigMaps & Secrets
```bash
# Create configmap from file
kubectl create configmap my-config --from-file=config.properties

# Create configmap from literal
kubectl create configmap my-config --from-literal=key=value

# Create secret from literal
kubectl create secret generic my-secret --from-literal=password=secret123

# View configmap
kubectl get configmap my-config -o yaml

# View secret (base64 encoded)
kubectl get secret my-secret -o yaml

# Decode secret
kubectl get secret my-secret -o jsonpath='{.data.password}' | base64 -d
```

### Debugging
```bash
# Get events
kubectl get events

# Get events sorted by time
kubectl get events --sort-by='.lastTimestamp'

# Describe all pods in namespace
kubectl describe pods -n production

# Check resource usage
kubectl top nodes
kubectl top pods

# Run debug pod
kubectl run debug --image=busybox -it --rm -- sh

# Test service connectivity
kubectl run test --image=busybox -it --rm -- wget -qO- http://service-name:80
```

## ⛵ Helm Commands

### Chart Management
```bash
# Create new chart
helm create my-chart

# Validate chart
helm lint ./my-chart

# Template chart (dry run)
helm template my-app ./my-chart

# Package chart
helm package ./my-chart
```

### Release Management
```bash
# Install chart
helm install my-app ./my-chart

# Install with custom values
helm install my-app ./my-chart -f values-prod.yaml

# Install with set values
helm install my-app ./my-chart --set replicaCount=3

# List releases
helm list

# Get release status
helm status my-app

# Get release values
helm get values my-app

# Upgrade release
helm upgrade my-app ./my-chart

# Rollback release
helm rollback my-app 1

# Uninstall release
helm uninstall my-app

# Uninstall and keep history
helm uninstall my-app --keep-history
```

### Repository Management
```bash
# Add repository
helm repo add stable https://charts.helm.sh/stable

# Update repositories
helm repo update

# Search charts
helm search repo nginx

# List repositories
helm repo list
```

## 🏗️ Terraform Commands

### Initialization
```bash
# Initialize working directory
terraform init

# Initialize with backend upgrade
terraform init -upgrade

# Initialize and migrate state
terraform init -migrate-state
```

### Planning & Applying
```bash
# Create execution plan
terraform plan

# Plan with variables file
terraform plan -var-file="prod.tfvars"

# Plan specific target
terraform plan -target=aws_instance.web

# Apply changes
terraform apply

# Apply with auto approval
terraform apply -auto-approve

# Apply specific target
terraform apply -target=aws_instance.web

# Destroy infrastructure
terraform destroy
```

### State Management
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Show specific resource
terraform state show aws_instance.web

# Move resource in state
terraform state mv aws_instance.web aws_instance.web-server

# Remove resource from state
terraform state rm aws_instance.web

# Import existing resource
terraform import aws_instance.web i-1234567890abcdef0

# Refresh state
terraform refresh
```

### Validation & Formatting
```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Format and show differences
terraform fmt -diff

# Check format
terraform fmt -check
```

### Workspaces
```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new production

# Switch workspace
terraform workspace select production

# Delete workspace
terraform workspace delete staging
```

## 🚨 Monitoring Commands (Prometheus/Grafana)

### Prometheus
```bash
# Check Prometheus targets
curl http://localhost:9090/api/v1/targets

# Query metrics
curl "http://localhost:9090/api/v1/query?query=up"

# Check alert rules
curl http://localhost:9090/api/v1/rules

# Reload configuration
curl -X POST http://localhost:9090/-/reload

# Check configuration
promtool check config prometheus.yml

# Check rules
promtool check rules alerts/rules.yml
```

### Alertmanager
```bash
# Check Alertmanager status
curl http://localhost:9093/api/v1/status

# Send test alert
curl -XPOST http://localhost:9093/api/v1/alerts -H "Content-Type: application/json" -d '[{
  "labels": {"alertname": "TestAlert", "severity": "warning"},
  "annotations": {"summary": "Test alert"}
}]'

# Check configuration
amtool check-config alertmanager.yml
```

## 🔧 Git Commands

### Basic Operations
```bash
# Clone repository
git clone https://github.com/user/repo.git

# Check status
git status

# Add files
git add .
git add file.txt

# Commit changes
git commit -m "Add new feature"

# Push changes
git push origin main

# Pull changes
git pull origin main

# Create branch
git checkout -b feature/new-feature

# Switch branch
git checkout main

# Merge branch
git merge feature/new-feature

# Delete branch
git branch -d feature/new-feature
```

### Troubleshooting
```bash
# View commit history
git log --oneline

# Show changes
git diff

# Reset to last commit
git reset --hard HEAD

# Stash changes
git stash
git stash pop

# Undo last commit (keep changes)
git reset --soft HEAD~1
```

## 🔍 System Debugging Commands

### Process & System Info
```bash
# Check running processes
ps aux

# Check system resources
top
htop

# Check memory usage
free -h

# Check disk usage
df -h

# Check network connections
netstat -tulpn

# Check listening ports
ss -tulpn

# Test network connectivity
ping google.com
telnet localhost 8080
curl -I http://localhost:8080
```

### Log Analysis
```bash
# View system logs
journalctl -f

# View logs for specific service
journalctl -u docker

# View last 100 lines
tail -n 100 /var/log/syslog

# Follow log file
tail -f /var/log/application.log

# Search in logs
grep "ERROR" /var/log/application.log
```

## 💡 Quick Troubleshooting Workflow

### When Something Doesn't Work:
```bash
# 1. Check if resource exists
kubectl get pods,svc,deployment -n namespace

# 2. Describe the resource
kubectl describe pod pod-name

# 3. Check logs
kubectl logs pod-name

# 4. Check events
kubectl get events --sort-by='.lastTimestamp'

# 5. Test connectivity
kubectl exec -it pod-name -- wget -qO- http://service:port

# 6. Check resource limits
kubectl top pods
```
