resource "null_resource" "k3d_cluster" {
    triggers = {
        cluster_name = var.cluster_name
        nodes        = var.nodes
    }

provisioner "local-exec" {
    command = "k3d cluster create ${self.triggers.cluster_name} --servers 1 --agents ${self.triggers.nodes} -p 8080:80@loadbalancer -p 6443:6443"
}


    provisioner "local-exec" {
        when    = destroy
        command = "k3d cluster delete ${self.triggers.cluster_name}"
    }
    }
