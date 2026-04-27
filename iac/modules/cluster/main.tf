terraform {
required_providers {
    k3d = {
        source  = "sneakybugs/k3d"
        version = ">= 1.0.0"
        }
    }
}
resource "k3d_cluster" "this" {
  name = var.cluster_name

  k3d_config = <<EOF
apiVersion: k3d.io/v1alpha5
kind: Simple
metadata:
  name: ${var.cluster_name}
servers: 1
agents: ${var.nodes}
ports:
  - port: "8086:80"
    nodeFilters:
      - "loadbalancer"
EOF
}