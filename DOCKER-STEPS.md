# Docker Deployment Steps

## 🐳 Docker Commands Reference

### Build Images
```bash
# Build server image
cd docker/server
docker build -t mensa-server:latest .

# Build client image  
cd ../client
docker build -t mensa-client:latest .

# List built images
docker images | grep mensa
```

### Run Single Container
```bash
# Run server container
docker run -d \
  --name mensa-server \
  -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=docker \
  mensa-server:latest

# Run client container
docker run -d \
  --name mensa-client \
  -p 3000:80 \
  mensa-client:latest

# Check running containers
docker ps
```

### Docker Compose Deployment
```bash
# Start all services
docker-compose up -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f mensa-server
docker-compose logs -f mensa-client

# Scale services
docker-compose up -d --scale mensa-server=3

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

### Container Management
```bash
# Execute commands in container
docker exec -it mensa-server /bin/bash

# Copy files to/from container
docker cp file.txt mensa-server:/app/
docker cp mensa-server:/app/logs ./

# View container logs
docker logs mensa-server --tail=50 -f

# Inspect container
docker inspect mensa-server
```

### Image Management
```bash
# Tag image for registry
docker tag mensa-server:latest your-registry/mensa-server:v1.0

# Push to registry
docker push your-registry/mensa-server:v1.0

# Pull from registry
docker pull your-registry/mensa-server:v1.0

# Remove images
docker rmi mensa-server:latest

# Clean up unused images
docker image prune -f
```

## 🔧 Troubleshooting

### Debug Container Issues
```bash
# Check container status
docker ps -a

# View detailed logs
docker logs mensa-server --details

# Check resource usage
docker stats mensa-server

# Inspect network
docker network ls
docker network inspect bridge
```

### Port and Network Issues
```bash
# Check port binding
docker port mensa-server

# Test connectivity
curl http://localhost:8080/health

# Check exposed ports
docker inspect mensa-server | grep ExposedPorts -A 5
```
