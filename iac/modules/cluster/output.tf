output "host" {
    value = k3d_cluster.this.host
}

output "client_certificate" {
    value     = k3d_cluster.this.client_certificate
    sensitive = true
}

output "client_key" {
    value     = k3d_cluster.this.client_key
    sensitive = true
}

output "cluster_ca_certificate" {
    value     = k3d_cluster.this.cluster_ca_certificate
    sensitive = true
}
output "cluster_name" {
    value = k3d_cluster.this.name
}

output "nodes" {
    value = var.nodes
}