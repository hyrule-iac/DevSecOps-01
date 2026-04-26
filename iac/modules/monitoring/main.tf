resource "helm_release" "prometheus_stack" {
  name             = "obs"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  wait             = false # Acelera el despliegue inicial

  # Usamos la sintaxis de bloque dinámico o simple
  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = "false"
  }

  set {
    name  = "prometheus.prometheusSpec.retention"
    value = "1d"
  }
}