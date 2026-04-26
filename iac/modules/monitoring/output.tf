output "monitoring_namespace" {
  value = helm_release.prometheus_stack.namespace
}

output "grafana_admin_password" {
  value     = "prom-operator" # Contraseña por defecto del chart
  sensitive = true
}