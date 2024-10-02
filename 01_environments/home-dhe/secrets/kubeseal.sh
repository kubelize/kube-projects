kubeseal --format=yaml \
  --cert=/home/dan/Git/kubelize/kube-projects/01_environments/home-dhe/secrets/pub-home-dhe-sealed-secrets.pem \
  --secret-file /home/dan/Git/kubelize/kube-projects/00_base/incubator/keycloak/secret.yaml \
  --sealed-secret-file /home/dan/Git/kubelize/kube-projects/00_base/incubator/keycloak/keycloak-admin-credentials.yaml