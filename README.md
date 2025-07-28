# DevOps Exam Preparation - Mensa Lab

A comprehensive repository containing ready-to-use DevOps templates and configurations for practical exam preparation.

## 📁 Repository Structure

```
├── .github/workflows/    # CI/CD pipelines
├── docker/              # Multi-stage Dockerfiles
│   ├── client/          # Node.js + Nginx frontend
│   └── server/          # Java Spring Boot backend
├── k8s/                 # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml   # Configuration management
│   └── statefulset.yaml # Database deployment
├── helm/                # Helm chart templates
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
├── terraform/           # Infrastructure as Code
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── monitoring/          # Observability stack
│   ├── docker-compose.monitoring.yml
│   ├── prometheus.yml
│   ├── alerts/          # Prometheus alerting rules
│   └── grafana/         # Dashboards & provisioning
├── ansible/             # Configuration management
│   ├── inventory.ini    # Host definitions
│   ├── site.yml         # Main playbook
│   ├── tasks/           # Task files
│   └── playbooks/       # Specific playbooks
├── docker-compose.yml   # Multi-service orchestration
├── .env.example         # Environment template
├── DEPLOYMENT-STEPS.md  # 📋 Manual K8s deployment guide
├── DOCKER-STEPS.md      # 🐳 Docker commands reference  
├── HELM-STEPS.md        # ⛵ Helm deployment guide
├── TERRAFORM-STEPS.md   # 🏗️ Terraform commands reference
├── ANSIBLE-STEPS.md     # 🔧 Ansible configuration management
├── MONITORING-STEPS.md  # 🚨 Prometheus & Grafana alerting
├── EXAM-SCENARIOS.md    # 🎯 Sample exam questions & solutions
└── EXAM-COMMANDS.md     # ⚡ Quick command reference cheat sheet
```

## 🚀 Quick Reference

### Docker & Docker Compose
- **Multi-stage builds** for optimized container images
- Frontend: Node.js build → Nginx runtime
- Backend: Maven build → OpenJDK runtime
- **Full-stack orchestration** with database

### Kubernetes
- Complete deployment configuration with 2 replicas
- ClusterIP service for internal communication
- Nginx ingress with path-based routing
- **ConfigMaps & Secrets** for configuration management
- **StatefulSets** for stateful applications (database)

### Helm
- Parameterized chart for flexible deployments
- Configurable replica count and image tags
- Built-in ingress support

### Ansible
- **Host inventory** for server management
- **Basic playbooks** for common tasks
- **Simple configuration** management

### Terraform
- Kubernetes provider configuration
- Namespace and deployment resources
- Infrastructure as Code examples

### CI/CD & Monitoring
- **GitHub Actions** pipeline for automated deployment
- **Prometheus & Grafana** for metrics and visualization
- **Alertmanager** for alert routing and notifications
- **Custom alerting rules** for common monitoring scenarios
- Health checks and rollout strategies

## 💡 Usage Tips

1. **Manual Deployment**: Follow step-by-step guides in `*-STEPS.md` files
2. **Docker**: Build images with `docker build -t app:tag .`
3. **Docker Compose**: `docker-compose up -d` for multi-service deployment
4. **K8s**: Follow `DEPLOYMENT-STEPS.md` for proper namespace deployment
5. **Helm**: Use `HELM-STEPS.md` for chart-based deployments
6. **Terraform**: Follow `TERRAFORM-STEPS.md` for infrastructure as code
6. **Terraform**: Initialize and apply with `terraform init && terraform apply`
7. **Ansible**: Run playbooks with `ansible-playbook site.yml`
8. **Monitoring**: `docker-compose -f monitoring/docker-compose.monitoring.yml up -d`
8. **Alerts**: Access Prometheus (9090), Alertmanager (9093), Grafana (3001)

### 🔧 Essential Exam Commands
```bash
# Docker essentials
docker build -t myapp .
docker run -p 8080:8080 myapp
docker-compose up -d

# Kubernetes with namespace
kubectl create namespace mensa
kubectl apply -f . -n mensa
kubectl get pods -n mensa
kubectl logs deployment/myapp -n mensa
kubectl port-forward svc/myapp 8080:80 -n mensa

# Helm operations
helm install myapp ./chart
helm upgrade myapp ./chart
helm rollback myapp 1

# Terraform workflow
terraform init
terraform plan
terraform apply
terraform destroy
```

### 📋 Step-by-Step Guides
- **[Kubernetes Deployment](DEPLOYMENT-STEPS.md)** - Complete manual K8s deployment
- **[Docker Commands](DOCKER-STEPS.md)** - Container management reference
- **[Helm Operations](HELM-STEPS.md)** - Chart deployment guide  
- **[Terraform Workflow](TERRAFORM-STEPS.md)** - Infrastructure as code steps
- **[Ansible Configuration](ANSIBLE-STEPS.md)** - Server configuration management
- **[Monitoring & Alerting](MONITORING-STEPS.md)** - Prometheus & Grafana setup
- **[Exam Scenarios](EXAM-SCENARIOS.md)** - Sample questions with solutions
- **[Command Cheat Sheet](EXAM-COMMANDS.md)** - ⚡ Quick reference for all tools

Perfect for hands-on DevOps exam preparation!
