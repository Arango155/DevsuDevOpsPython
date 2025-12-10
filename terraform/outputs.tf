output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.devsu.kube_config.0.raw_config
  sensitive = true
}

output "cluster_name" {
  value = digitalocean_kubernetes_cluster.devsu.name
}
