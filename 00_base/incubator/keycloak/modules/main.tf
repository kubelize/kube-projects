resource "keycloak_realm" "my_realm" {
  realm   = "myrealm"
  enabled = true
}

resource "keycloak_role" "realm_role" {
  realm_id = keycloak_realm.my_realm.id
  name     = "admin"
}

resource "keycloak_group" "developers" {
  realm_id = keycloak_realm.my_realm.id
  name     = "developers"
}

resource "keycloak_group_roles" "group_roles" {
  realm_id   = keycloak_realm.my_realm.id
  group_id   = keycloak_group.developers.id
  role_ids   = [keycloak_role.realm_role.id]
}

resource "keycloak_user" "user" {
  realm_id    = keycloak_realm.my_realm.id
  username    = "john.doe"
  enabled     = true
  initial_password {
    value     = "password"
    temporary = false
  }
}

resource "keycloak_user_group_memberships" "user_group" {
  realm_id = keycloak_realm.my_realm.id
  user_id  = keycloak_user.user.id
  group_ids = [keycloak_group.developers.id]
}
