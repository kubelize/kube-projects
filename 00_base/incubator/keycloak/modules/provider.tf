provider "kubernetes" {}

data "kubernetes_secret" "keycloak_credentials" {
  metadata {
    name      = "keycloak-admin-credentials"
    namespace = "keycloak"
  }
}

provider "keycloak" {
  client_id = cli-admin
  username  = admin
  password  = base64decode(data.kubernetes_secret.keycloak_credentials.data["password"])
  url       = "http://keycloak.keycloak.svc.cluster.local:80"
  realm     = "master"
}

