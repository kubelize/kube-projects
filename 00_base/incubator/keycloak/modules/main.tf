provider "kubernetes" {}

# Fetch the secret from Kubernetes
data "kubernetes_secret" "keycloak_credentials" {
  metadata {
    name      = "keycloak-admin-credentials"
    namespace = "keycloak"
  }
}

# Decode the password from the secret
locals {
  decoded_password = base64decode(data.kubernetes_secret.keycloak_credentials.data["password"])
}

# Echo messages and the secret value
resource "null_resource" "print_secret_info" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Collecting data from secret..."
      echo "Admin Password is: ${local.decoded_password}"
    EOT
  }
}
