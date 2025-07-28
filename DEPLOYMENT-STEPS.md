# Kubernetes Deployment Steps

## 🚀 Manual Deployment Guide

### Prerequisites
```bash
# Verify kubectl is configured
kubectl cluster-info
kubectl config current-context

# Check available namespaces
kubectl get namespaces
```

### Step 1: Create Namespace
```bash
# Create the mensa namespace
kubectl create namespace mensa

# Verify namespace creation
kubectl get namespaces
```

### Step 2: Apply Configuration Resources First
```bash
# Apply ConfigMaps and Secrets (dependencies)
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml

# Verify configs
kubectl get configmaps -n mensa
kubectl get secrets -n mensa
```

### Step 3: Deploy Database (StatefulSet)
```bash
# Deploy PostgreSQL database
kubectl apply -f k8s/statefulset.yaml

# Wait for StatefulSet to be ready
kubectl wait --for=condition=ready pod/postgres-0 -n mensa --timeout=300s

# Check StatefulSet status
kubectl get statefulsets -n mensa
kubectl get pods -n mensa -l app=postgres
```

### Step 4: Deploy Application
```bash
# Deploy the main application
kubectl apply -f k8s/deployment.yaml

# Wait for deployment to be ready
kubectl wait --for=condition=available deployment/mensa-server -n mensa --timeout=300s

# Check deployment status
kubectl get deployments -n mensa
kubectl get pods -n mensa -l app=mensa-server
```

### Step 5: Create Services
```bash
# Apply service configurations
kubectl apply -f k8s/service.yaml

# Verify services
kubectl get services -n mensa
kubectl describe svc/mensa-server-svc -n mensa
```

### Step 6: Configure Ingress (Optional)
```bash
# Apply ingress rules
kubectl apply -f k8s/ingress.yaml

# Check ingress status
kubectl get ingress -n mensa
kubectl describe ingress/mensa-ingress -n mensa
```

### Step 7: Verify Deployment
```bash
# Check all resources in namespace
kubectl get all -n mensa

# Check pod logs
kubectl logs deployment/mensa-server -n mensa

# Test connectivity with port forwarding
kubectl port-forward svc/mensa-server-svc 8080:80 -n mensa
# Then access http://localhost:8080 in browser
```

## 🔧 Troubleshooting Commands

### Check Pod Status
```bash
# Detailed pod information
kubectl describe pods -n mensa

# Pod logs for debugging
kubectl logs -l app=mensa-server -n mensa --tail=50

# Enter pod for debugging
kubectl exec -it deployment/mensa-server -n mensa -- /bin/sh
```

### Check Network Connectivity
```bash
# Test service DNS resolution
kubectl run test-pod --image=busybox -n mensa --rm -it -- nslookup mensa-server-svc

# Test service connectivity
kubectl run test-pod --image=busybox -n mensa --rm -it -- wget -qO- mensa-server-svc:80
```

### Resource Management
```bash
# Scale deployment
kubectl scale deployment/mensa-server --replicas=3 -n mensa

# Update image
kubectl set image deployment/mensa-server server=your-registry/mensa-server:v2 -n mensa

# Rollback deployment
kubectl rollout undo deployment/mensa-server -n mensa
```

## 🧹 Cleanup Steps

### Remove Application
```bash
# Delete individual resources
kubectl delete -f k8s/ingress.yaml
kubectl delete -f k8s/service.yaml
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/statefulset.yaml
kubectl delete -f k8s/configmap.yaml

# Or delete entire namespace (removes everything)
kubectl delete namespace mensa
```

### Verify Cleanup
```bash
# Check namespace is gone
kubectl get namespaces

# Check no leftover PVCs
kubectl get pvc --all-namespaces
```

## ⚡ Quick Reference Commands

### Essential kubectl commands for exams:
```bash
# Resource management
kubectl apply -f <file> -n <namespace>
kubectl delete -f <file> -n <namespace>
kubectl get <resource> -n <namespace>
kubectl describe <resource> <name> -n <namespace>

# Pod operations
kubectl logs <pod-name> -n <namespace>
kubectl exec -it <pod-name> -n <namespace> -- <command>
kubectl port-forward <pod-name> <local-port>:<remote-port> -n <namespace>

# Debugging
kubectl get events -n <namespace> --sort-by='.lastTimestamp'
kubectl top pods -n <namespace>
kubectl get pods -n <namespace> -o wide
```

## 📝 Exam Tips

1. **Always specify namespace** with `-n <namespace>`
2. **Check events** when things fail: `kubectl get events -n mensa`
3. **Use describe** for detailed information: `kubectl describe pod <name> -n mensa`
4. **Check logs** for application issues: `kubectl logs <pod> -n mensa`
5. **Verify connectivity** with port-forward before ingress
6. **Order matters**: ConfigMaps/Secrets → Database → Application → Services → Ingress
