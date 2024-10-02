resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "test-nginx"
    labels = {
      App = "test-nginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "test-nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "test-nginx"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "test-nginx"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
