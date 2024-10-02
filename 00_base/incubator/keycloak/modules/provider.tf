provider "kubernetes" {}

data "kubernetes_secret" "keycloak_credentials" {
  metadata {
    name      = "keycloak-admin-credentials"
    namespace = "keycloak"
  }
}

provider "keycloak" {
  client_id = base64decode(data.kubernetes_secret.keycloak_credentials.data["client_id"])
  username  = admin
  password  = base64decode(data.kubernetes_secret.keycloak_credentials.data["password"])
  url       = "http://keycloak"
  realm     = "master"
}

