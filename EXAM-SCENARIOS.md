# Sample Exam Questions - Monitoring & Alerting

## 🎯 Common Exam Scenarios

### Scenario 1: Create a High CPU Alert
**Task**: Create an alert that triggers when CPU usage exceeds 80% for more than 2 minutes.

**Solution**:
```yaml
# Add to alerts/rules.yml
- alert: HighCPUUsage
  expr: rate(container_cpu_usage_seconds_total{container="server"}[5m]) * 100 > 80
  for: 2m
  labels:
    severity: warning
  annotations:
    summary: "High CPU usage detected"
    description: "CPU usage is above 80% for container {{ $labels.container }}"
```

### Scenario 2: Configure Email Notifications
**Task**: Configure Alertmanager to send critical alerts to admin@company.com

**Solution**:
```yaml
# Update alerts/alertmanager.yml
receivers:
  - name: 'admin-alerts'
    email_configs:
      - to: 'admin@company.com'
        subject: 'CRITICAL: {{ .GroupLabels.alertname }}'
        body: |
          Alert: {{ range .Alerts }}{{ .Annotations.summary }}{{ end }}
          Time: {{ .CommonAnnotations.timestamp }}

route:
  routes:
    - match:
        severity: critical
      receiver: 'admin-alerts'
```

### Scenario 3: Create a Grafana Dashboard Panel
**Task**: Add a panel showing HTTP request rate over time

**Solution**:
```json
{
  "title": "HTTP Request Rate",
  "type": "graph",
  "targets": [
    {
      "expr": "rate(http_requests_total[5m])",
      "legendFormat": "{{method}} {{status}}"
    }
  ],
  "yAxes": [
    {
      "label": "Requests per second"
    }
  ]
}
```

### Scenario 4: Database Connection Alert
**Task**: Alert when database connections exceed 80% of maximum

**Solution**:
```yaml
- alert: DatabaseConnectionHigh
  expr: db_connections_active / db_connections_max * 100 > 80
  for: 1m
  labels:
    severity: warning
  annotations:
    summary: "Database connections running high"
    description: "{{ $value }}% of database connections are in use"
```

### Scenario 5: Disk Space Alert
**Task**: Create an alert for when disk space falls below 10%

**Solution**:
```yaml
- alert: DiskSpaceLow
  expr: (node_filesystem_avail_bytes / node_filesystem_size_bytes) * 100 < 10
  for: 5m
  labels:
    severity: critical
  annotations:
    summary: "Disk space critically low"
    description: "Only {{ $value }}% disk space remaining on {{ $labels.instance }}"
```

## 📊 Dashboard Creation Tasks

### Task: Create Application Overview Dashboard

**Requirements**:
1. Service status indicator
2. Request rate graph
3. Error rate percentage
4. Response time percentiles
5. Resource usage (CPU/Memory)

**Solution**: Use the provided `mensa-dashboard.json` as template and modify panels as needed.

## 🔧 Troubleshooting Scenarios

### Scenario: Alert Not Firing
**Problem**: Alert defined but not triggering

**Debugging Steps**:
```bash
# 1. Check Prometheus targets
curl http://localhost:9090/api/v1/targets

# 2. Test PromQL query
curl "http://localhost:9090/api/v1/query?query=up{job=\"mensa-server\"}"

# 3. Check alert rules
curl http://localhost:9090/api/v1/rules

# 4. Validate configuration
docker exec prometheus promtool check config /etc/prometheus/prometheus.yml
```

### Scenario: Grafana Dashboard Not Loading Data
**Problem**: Dashboard shows "No data"

**Debugging Steps**:
```bash
# 1. Test Prometheus connection
curl http://localhost:9090/api/v1/query?query=up

# 2. Check Grafana datasource
# Go to Configuration > Data Sources > Test

# 3. Verify query syntax in dashboard panel
```

## 💡 Exam Tips

### Alert Rule Best Practices
1. **Use appropriate `for` duration** - avoid false positives
2. **Include meaningful labels** - for routing and grouping
3. **Write clear annotations** - for actionable information
4. **Test alert expressions** - in Prometheus before deploying

### Common PromQL Functions
```promql
# Rate of increase
rate(metric[5m])

# Average over time
avg_over_time(metric[10m])

# Percentiles
histogram_quantile(0.95, metric_bucket)

# Aggregation
sum by (label) (metric)

# Comparison operators
metric > 0.8
metric != 0
```

### Dashboard Panel Types
- **Graph**: Time series data
- **Stat**: Single value with thresholds
- **Gauge**: Progress indicators
- **Table**: Tabular data
- **Heatmap**: Distribution over time
