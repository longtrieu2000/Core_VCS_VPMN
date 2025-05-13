Vault la noi luu tru key api

Unseal Vault (Chỉ Dành Cho Production)

Vault mặc định yêu cầu Unseal Key để mở khóa sau mỗi lần khởi động.

🔹 Chế độ Shamir’s Secret Sharing (Thủ công)

bash

    vault operator init

✔ Vault sẽ in ra 5 Unseal Keys và Root Token (giữ cẩn thận).

✔ Bạn cần nhập ít nhất 3/5 keys để mở khóa Vault:

bash

    vault operator unseal <UNSEAL_KEY_1>
    vault operator unseal <UNSEAL_KEY_2>
    vault operator unseal <UNSEAL_KEY_3>

🔹 Tạo Root Token

Nếu chưa có root token, bạn có thể lấy lại bằng cách:

bash

    vault operator init

Sau khi chạy, Vault sẽ cung cấp:

5 Unseal Keys

Root Token (quan trọng, dùng để đăng nhập lần đầu)

Lưu trữ các thông tin này ở nơi an toàn!

🔹 Đăng nhập bằng root token:

bash

    vault login <ROOT_TOKEN>

    
🔹 Bật Secrets Engine (kv)

Vault hỗ trợ nhiều loại secrets engine, ở đây dùng kv (Key-Value Store):

bash

    vault secrets enable -path=secret kv-v2

🔹 Tạo User Trong Vault

Vault sử dụng Userpass để quản lý user.

Bật Userpass Authentication

bash

    vault auth enable userpass

Tạo User

bash

    vault write auth/userpass/users/<username> password="<password>" policies="default"

📌 Ví dụ tạo user monitor với policy read-only:

bash

    vault write auth/userpass/users/monitor password="mypassword" policies="read-only"


🔹 Quản Lý Token Trong Vault

Tạo Token Mới

bash

    vault token create -policy="default"

Hoặc tạo token với TTL:

bash

    vault token create -policy="default" -ttl=24h

Kiểm Tra Token

bash

    vault token lookup <TOKEN>

Hủy Token

bash

    vault token revoke <TOKEN>

 6️⃣ Gán Policy Và Nạp Vào Container
 
Bạn có thể tạo file policy.hcl để gán quyền cho user.

🔹 Ví dụ: policy read-only.hcl

hcl

    path "secret/data/*" {
      capabilities = ["read"]
    }

🔹 Gán policy vào Vault

bash

    vault policy write read-only read-only.hcl

🔹 Mount file vào container Docker Compose

yaml

    volumes:
      - ./read-only.hcl:/vault/config/read-only.hcl

Tạo Policy Full Quyền Trong Vault

Policy trong HashiCorp Vault được sử dụng để kiểm soát quyền truy cập. Nếu bạn muốn tạo policy với full quyền, bạn có thể làm như sau.

📌  Tạo Policy Full Quyền

🔹 Tạo file policy có tên admin-policy.hcl:

hcl

# Policy full quyền

    path "*" {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }

📌 Giải thích:

create - Cho phép tạo dữ liệu.

read - Cho phép đọc dữ liệu.

update - Cho phép cập nhật dữ liệu.

delete - Cho phép xóa dữ liệu.

list - Cho phép liệt kê dữ liệu.

sudo - Cấp quyền quản trị.

📌  Gán Policy Vào Vault

🔹 Chạy lệnh sau để nạp policy vào Vault:

bash

    vault policy write admin admin-policy.hcl

Lệnh này sẽ tạo policy có tên admin từ file admin-policy.hcl.

📌 Gán Policy Cho User

🔹 Nếu bạn muốn cấp quyền full access cho user admin, chạy lệnh:

bash

    vault write auth/userpass/users/admin password="mypassword" policies="admin"

🔹 Nếu bạn muốn cấp policy cho Root Token:

bash

    vault token create -policy="admin"

📌 Kiểm Tra Policy

📌 Xem danh sách policy đã có trong Vault:

bash

    vault policy list

📌 Xem nội dung policy admin:

bash

    vault policy read admin
