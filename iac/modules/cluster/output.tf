output "cluster_id" {
    value = k3d_cluster.devsecops.id
}

output "kubeconfig_context" {
    value = "k3d-${var.cluster_name}"
}