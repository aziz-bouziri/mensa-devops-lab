output "namespace" {
  value = kubernetes_namespace.mensa.metadata[0].name
}