variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  default     = "devsu-cluster"
}

variable "region" {
  description = "DigitalOcean region"
  default     = "nyc1"
}

variable "node_size" {
  description = "Droplet size for Kubernetes nodes"
  default     = "s-1vcpu-2gb"
}
