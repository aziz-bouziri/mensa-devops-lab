# DevOps Exam Preparation - Mensa Lab

A comprehensive repository containing ready-to-use DevOps templates and configurations for practical exam preparation.

## Repository Structure

```
├── docker/           # Multi-stage Dockerfiles
│   ├── client/       # Node.js + Nginx frontend
│   └── server/       # Java Spring Boot backend
├── k8s/              # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── helm/             # Helm chart templates
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── terraform/        # Infrastructure as Code
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

## Quick Reference

### Docker
- **Multi-stage builds** for optimized container images
- Frontend: Node.js build → Nginx runtime
- Backend: Maven build → OpenJDK runtime

### Kubernetes
- Complete deployment configuration with 2 replicas
- ClusterIP service for internal communication
- Nginx ingress with path-based routing

### Helm
- Parameterized chart for flexible deployments
- Configurable replica count and image tags
- Built-in ingress support

### Terraform
- Kubernetes provider configuration
- Namespace and deployment resources
- Infrastructure as Code examples

## Usage Tips

1. **Docker**: Build images with `docker build -t app:tag .`
2. **K8s**: Apply with `kubectl apply -f k8s/`
3. **Helm**: Deploy with `helm install mensa-app ./helm`
4. **Terraform**: Initialize and apply with `terraform init && terraform apply`

Perfect for hands-on DevOps exam preparation! 🎯
