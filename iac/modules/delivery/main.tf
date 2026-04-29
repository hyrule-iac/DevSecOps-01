resource "helm_release" "argo_rollouts" {
  name = "argo"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-rollouts"
  namespace = var.namespace
  create_namespace = true

  set {
    name = "dashboards.enabled"
    value = true
  }
}
