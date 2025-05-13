Thêm API Key Bằng API (Dành Cho DevOps & Automation)

Nếu bạn muốn thêm key vào Vault bằng HTTP API:

bash

    curl --header "X-Vault-Token: root" \
         --request POST \
         --data '{"data": {"service": "fortigate", "api_key": "123456789abcdef"}}' \
         http://127.0.0.1:8200/v1/secret/data/api_keys

📌 Kiểm tra lại bằng API:

bash
    
    curl --header "X-Vault-Token: root" \
         --request GET \
         http://127.0.0.1:8200/v1/secret/data/api_keys
         
Lấy API Key Từ Vault Trong Docker-Compose

Nếu bạn muốn container sử dụng API key từ Vault, có thể inject nó vào environment:

yaml

    version: "3.8"
    
    services:
      app:
        image: my-app
        container_name: my-app
        environment:
          API_KEY: "${VAULT_API_KEY}"
        command: ["sh", "-c", "echo API_KEY=$API_KEY"]

📌 Lấy API Key từ Vault và set vào biến môi trường:

bash

    export VAULT_API_KEY=$(vault kv get -field=api_key secret/api_keys)
    docker-compose up
    
📌 Thêm API Key Vào Vault

Thêm một API key vào Vault dưới path secret/api_keys:

bash

    vault kv put secret/api_keys service="fortigate" api_key="123456789abcdef"

📌 Kiểm tra lại:

bash

    vault kv get secret/api_keys

📌 Thêm Secrets (Lưu dữ liệu)

    vault kv put secret/myapp/config username="admin" password="secrets"

Kiểm thử truy cập:

    vault kv get secret/myapp/config
