# 📋 DevOps Exam Checklist

## Pre-Exam Preparation
- [ ] Run `./scripts/pre-exam-setup.sh` to pull all required Docker images
- [ ] Test Docker daemon is running: `docker --version`
- [ ] Test Kubernetes access: `kubectl cluster-info`
- [ ] Test Helm installation: `helm version`
- [ ] Review `EXAM-COMMANDS.md` for command reference
- [ ] Review `EXAM-SCENARIOS.md` for practice scenarios

## Required Tools Verification
- [ ] Docker Engine installed and running
- [ ] kubectl configured with cluster access
- [ ] Helm 3.x installed
- [ ] Git available for version control
- [ ] Text editor (vim/nano) available

## Docker Images Ready
- [ ] `gradle:8.13-jdk17` (Java builds)
- [ ] `eclipse-temurin:17-jre-noble` (Java runtime)
- [ ] `node:22-alpine` (Node.js builds)
- [ ] `nginx:1.29` (Web server)
- [ ] `postgres:17` (Database)
- [ ] `gcr.io/distroless/*` images (Security-focused)
- [ ] Base images: `debian:12-slim`, `ubuntu:24.04`, `alpine:3.22`

## Knowledge Areas to Review
- [ ] Multi-stage Docker builds
- [ ] Kubernetes manifest writing (Deployment, Service, Ingress)
- [ ] Helm chart templating with values
- [ ] ConfigMaps and Secrets management
- [ ] Resource limits and requests
- [ ] Namespace management
- [ ] Basic troubleshooting commands

## Common Exam Tasks
- [ ] Build and tag Docker images
- [ ] Deploy applications to Kubernetes
- [ ] Create and apply Helm charts
- [ ] Configure environment-specific deployments
- [ ] Set up ingress routing
- [ ] Configure persistent storage
- [ ] Debug failed deployments

## Quick Reference Files
- `EXAM-COMMANDS.md` - Essential commands with explanations
- `EXAM-SCENARIOS.md` - Practice scenarios
- `docker/` - Multi-stage Dockerfile examples
- `k8s/` - Complete Kubernetes manifests
- `helm/` - Templated Helm charts
- `*-STEPS.md` - Step-by-step guides

## Emergency Commands
```bash
# Check cluster status
kubectl get nodes
kubectl get pods --all-namespaces

# Check Docker
docker ps
docker images

# Check Helm
helm list --all-namespaces

# Quick cleanup
kubectl delete namespace mensa
docker system prune -f
```

## Time Management Tips
- Read the full question before starting
- Use existing templates from this repository
- Test incrementally (build → deploy → verify)
- Keep error messages for debugging
- Use `kubectl describe` for troubleshooting

## Final Reminders
- All images follow official exam specifications
- Templates are exam-optimized (not production-complex)
- Documentation includes exact commands needed
- Practice scenarios mirror potential exam tasks

Good luck! 🍀
