output "cluster_name" {
    value = null_resource.k3d_cluster.triggers.cluster_name
}

output "nodes" {
    value = null_resource.k3d_cluster.triggers.nodes
}

output "cluster_created" {
    value = null_resource.k3d_cluster.id
}
