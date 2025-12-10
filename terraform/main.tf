resource "digitalocean_kubernetes_cluster" "devsu" {
  name    = var.cluster_name
  region  = var.region
  version = "1.30.1-do.0"

  node_pool {
    name       = "devsu-worker-pool"
    size       = var.node_size
    node_count = 2
  }
}
