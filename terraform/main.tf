provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "mensa" {
  metadata { name = "mensa" }
}

# Example: deploy the server Deployment into the mensa namespace
resource "kubernetes_deployment" "server" {
  metadata {
    name      = "mensa-server"
    namespace = kubernetes_namespace.mensa.metadata[0].name
  }
  spec {
    replicas = 2
    selector { match_labels = { app = "mensa-server" } }
    template {
      metadata { labels = { app = "mensa-server" } }
      spec {
        container {
          name  = "server"
          image = "your-registry/mensa-server:latest"
          port { container_port = 8080 }
        }
      }
    }
  }
}