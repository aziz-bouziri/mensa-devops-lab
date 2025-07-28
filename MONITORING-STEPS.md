# Prometheus & Grafana Monitoring Setup

## Alerting Configuration Steps

### Step 1: Setup Monitoring Stack
```bash
# Start monitoring services
cd monitoring/
docker-compose -f docker-compose.monitoring.yml up -d

# Verify services are running
docker-compose -f docker-compose.monitoring.yml ps

# Check Prometheus targets
curl http://localhost:9090/api/v1/targets
```

### Step 2: Access Monitoring UIs
```bash
# Prometheus (metrics & alerts)
http://localhost:9090

# Alertmanager (alert routing)
http://localhost:9093

# Grafana (dashboards)
http://localhost:3001
# Login: admin/admin
```

### Step 3: Configure Grafana Dashboard
```bash
# Grafana should auto-provision:
# - Prometheus datasource
# - Mensa application dashboard

# Manual setup if needed:
# 1. Add Prometheus datasource: http://prometheus:9090
# 2. Import dashboard from grafana/dashboards/mensa-dashboard.json
```

### Step 4: Test Alerts
```bash
# Stop mensa server to trigger alert
docker-compose stop mensa-server

# Check alert in Prometheus
# Go to http://localhost:9090/alerts

# Check Alertmanager
# Go to http://localhost:9093

# Restart service
docker-compose start mensa-server
```

## Creating Custom Alerts (Exam Scenarios)

### Common Alert Types

#### 1. Service Availability Alert
```yaml
- alert: ServiceDown
  expr: up{job="mensa-server"} == 0
  for: 1m
  labels:
    severity: critical
  annotations:
    summary: "Service is down"
    description: "Mensa server is unreachable"
```

#### 2. High CPU Usage Alert
```yaml
- alert: HighCPUUsage
  expr: rate(container_cpu_usage_seconds_total[5m]) * 100 > 80
  for: 2m
  labels:
    severity: warning
  annotations:
    summary: "High CPU usage"
    description: "CPU usage above 80%"
```

#### 3. HTTP Error Rate Alert
```yaml
- alert: HighErrorRate
  expr: rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) * 100 > 5
  for: 3m
  labels:
    severity: warning
  annotations:
    summary: "High error rate"
    description: "5xx errors above 5%"
```

### Alert Configuration Files

#### Prometheus Rules (`alerts/rules.yml`)
- Contains alert definitions
- Uses PromQL expressions
- Defines thresholds and timing

#### Alertmanager Config (`alerts/alertmanager.yml`)
- Routes alerts to receivers
- Configures notification channels
- Groups and filters alerts

## Exam Tasks You Might Face

### Task 1: Create a Memory Usage Alert
```yaml
# Add to alerts/rules.yml
- alert: HighMemoryUsage
  expr: (container_memory_usage_bytes / container_spec_memory_limit_bytes) * 100 > 90
  for: 2m
  labels:
    severity: warning
  annotations:
    summary: "High memory usage detected"
    description: "Memory usage is above 90%"
```

### Task 2: Configure Email Notifications
```yaml
# Add to alerts/alertmanager.yml
receivers:
  - name: 'email-alerts'
    email_configs:
      - to: 'admin@company.com'
        subject: 'Alert: {{ .GroupLabels.alertname }}'
        body: |
          {{ range .Alerts }}
          Alert: {{ .Annotations.summary }}
          Description: {{ .Annotations.description }}
          {{ end }}
```

### Task 3: Create Grafana Dashboard Panel
```json
{
  "title": "Active Users",
  "type": "graph",
  "targets": [
    {
      "expr": "active_users_total",
      "legendFormat": "Active Users"
    }
  ]
}
```

## 🛠️ Troubleshooting Commands

### Check Alert Rules
```bash
# Validate Prometheus config
docker exec prometheus_container promtool check config /etc/prometheus/prometheus.yml

# Check rules syntax
docker exec prometheus_container promtool check rules /etc/prometheus/alerts/rules.yml

# Reload Prometheus config
curl -X POST http://localhost:9090/-/reload
```

### Test Alertmanager
```bash
# Check Alertmanager config
docker exec alertmanager_container amtool check-config /etc/alertmanager/alertmanager.yml

# Send test alert
curl -XPOST http://localhost:9093/api/v1/alerts -H "Content-Type: application/json" -d '[{
  "labels": {
    "alertname": "TestAlert",
    "severity": "warning"
  },
  "annotations": {
    "summary": "Test alert"
  }
}]'
```

### Debug Grafana
```bash
# Check Grafana logs
docker logs grafana_container

# Test datasource connection
curl -H "Authorization: Bearer YOUR_API_KEY" \
  http://localhost:3001/api/datasources/proxy/1/api/v1/query?query=up
```

## Quick Reference

### PromQL Queries for Alerts
```promql
# Service availability
up{job="service-name"} == 0

# CPU usage
rate(container_cpu_usage_seconds_total[5m]) * 100

# Memory usage
container_memory_usage_bytes / container_spec_memory_limit_bytes * 100

# HTTP error rate
rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) * 100

# Request latency
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))
```

### Common Alert Labels
- `severity: critical|warning|info`
- `team: backend|frontend|infrastructure`
- `service: mensa-server|mensa-client`
- `environment: production|staging|development`
