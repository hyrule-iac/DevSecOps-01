resource "k3d_cluster" "devsecops" {
    name = var.cluster_name
    servers = 1
    agents = var.nodes
    kube_api {
    host_ip = "127.0.0.1"
    host_port = 6443
    }
    port {
    host_port      = 8080
    container_port = 80
    node_filters   = ["loadbalancer"]
    }
}

