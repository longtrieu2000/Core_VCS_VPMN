#  Storage backend: PostgreSQL
storage "postgresql" {
  #connection_url = "postgres://${VAULT_DB_USER}:${VAULT_DB_PASS}@${VAULT_DB_HOST}:5432/${VAULT_DB_NAME}?sslmode=disable"
  connection_url = "postgres://vault_user:vault123qwe!A@192.168.113.200:5432/vault_db?sslmode=disable"
}

#  Listener: Sử dụng TLS để bảo mật
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable= true
  tls_cert_file = "/etc/vault/certs/vault.crt"
  tls_key_file  = "/etc/vault/certs/vault.key"
}

#  API & Cluster settingscur
api_addr     = "http://127.0.0.1:8200"
#cluster_addr = "https://vault.example.com:8201"

#  Bật UI cho Vault
ui = true

#  Disable mlock (Linux systems có thể cần bỏ dòng này)
#disable_mlock = true
