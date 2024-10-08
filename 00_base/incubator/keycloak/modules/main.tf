# Specify Terraform version and required providers
terraform {
  required_version = ">= 1.3.9"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"  # Or specify the version you're comfortable with
    }
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 4.4.0"  # Adjust as needed
    }
  }
}

# Kubernetes provider - automatically uses in-cluster config
provider "kubernetes" {}

# Keycloak provider
provider "keycloak" {
  client_id = "admin-cli"
  url       = "http://keycloak.keycloak.svc.cluster.local"
  username  = "identity-orchestrator"
  password  = local.keycloak_admin_password
  realm     = "master"
}

# Fetch the Keycloak admin credentials from the Kubernetes secret
data "kubernetes_secret" "keycloak_admin_secret" {
  metadata {
    name      = "keycloak-admin-credentials"
    namespace = "keycloak"  # Same namespace as the secret
  }
}

# Decode the base64-encoded values
locals {
  keycloak_admin_password = data.kubernetes_secret.keycloak_admin_secret.data["password"]
}

# Keycloak realm resource example
resource "keycloak_realm" "test" {
  realm   = "test"
  enabled = true
}

# Output realm id for visibility
output "keycloak_realm_id" {
  value = keycloak_realm.test.id
}

