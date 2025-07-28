# Helm Deployment Steps

## ⛵ Helm Commands Reference

### Chart Management
```bash
# Validate chart syntax
helm lint ./helm

# Dry run to see what would be deployed
helm install mensa-app ./helm --dry-run --debug

# Template rendering (see generated YAML)
helm template mensa-app ./helm
```

### Deploy Application
```bash
# Install chart
helm install mensa-app ./helm

# Install to specific namespace
helm install mensa-app ./helm --namespace mensa --create-namespace

# Install with custom values
helm install mensa-app ./helm --set replicaCount=3 --set image.tag=v2.0

# Install with values file
helm install mensa-app ./helm -f custom-values.yaml
```

### Manage Releases
```bash
# List all releases
helm list

# List releases in specific namespace
helm list -n mensa

# Get release status
helm status mensa-app

# Get release history
helm history mensa-app
```

### Update Deployments
```bash
# Upgrade release
helm upgrade mensa-app ./helm

# Upgrade with new values
helm upgrade mensa-app ./helm --set image.tag=v2.1

# Force upgrade
helm upgrade mensa-app ./helm --force

# Rollback to previous version
helm rollback mensa-app 1
```

### Debug and Troubleshoot
```bash
# Get rendered values
helm get values mensa-app

# Get all manifest of release
helm get manifest mensa-app

# Debug installation
helm install mensa-app ./helm --debug --dry-run

# Test release
helm test mensa-app
```

### Cleanup
```bash
# Uninstall release
helm uninstall mensa-app

# Uninstall from specific namespace
helm uninstall mensa-app -n mensa

# List uninstalled releases
helm list --uninstalled
```

## 📝 Custom Values Example

Create `custom-values.yaml`:
```yaml
replicaCount: 3

image:
  repository: your-registry/mensa-server
  tag: v2.0

service:
  type: LoadBalancer
  port: 80

ingress:
  enabled: true
  host: mensa.yourdomain.com
  
resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi
```

Then deploy:
```bash
helm install mensa-app ./helm -f custom-values.yaml
```
