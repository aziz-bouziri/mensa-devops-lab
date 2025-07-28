# Terraform Deployment Steps

## 🏗️ Terraform Commands Reference

### Initialize Terraform
```bash
# Initialize working directory
terraform init

# Upgrade providers
terraform init -upgrade

# Verify initialization
terraform version
```

### Plan Deployment
```bash
# Create execution plan
terraform plan

# Plan with variable file
terraform plan -var-file="prod.tfvars"

# Plan with specific variables
terraform plan -var="registry=my-registry"

# Save plan to file
terraform plan -out=deployment.plan
```

### Apply Changes
```bash
# Apply changes
terraform apply

# Apply saved plan
terraform apply deployment.plan

# Apply with auto-approval (careful!)
terraform apply -auto-approve

# Apply specific target
terraform apply -target=kubernetes_namespace.mensa
```

### Manage State
```bash
# Show current state
terraform show

# List resources in state
terraform state list

# Show specific resource
terraform state show kubernetes_deployment.server

# Import existing resource
terraform import kubernetes_namespace.mensa mensa
```

### Validate and Format
```bash
# Validate configuration
terraform validate

# Format code
terraform fmt

# Format and check differences
terraform fmt -diff
```

### Destroy Resources
```bash
# Plan destruction
terraform plan -destroy

# Destroy all resources
terraform destroy

# Destroy specific target
terraform destroy -target=kubernetes_deployment.server
```

## 📝 Variable Management

### Create `terraform.tfvars`:
```hcl
registry = "your-registry"
namespace = "mensa"
replicas = 3
image_tag = "v1.0"
```

### Environment-specific files:
```bash
# Development
terraform apply -var-file="dev.tfvars"

# Production  
terraform apply -var-file="prod.tfvars"
```

## 🔧 Troubleshooting

### Debug Commands
```bash
# Enable detailed logging
export TF_LOG=DEBUG
terraform apply

# Check provider versions
terraform providers

# Refresh state
terraform refresh

# Graph dependencies
terraform graph | dot -Tpng > graph.png
```

### Common Issues
```bash
# Force unlock state (if locked)
terraform force-unlock <lock-id>

# Fix state drift
terraform refresh
terraform plan

# Re-initialize with backend migration
terraform init -migrate-state
```
