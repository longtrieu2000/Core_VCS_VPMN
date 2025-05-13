✅ Mục tiêu:

Mã hóa file .env thành .env.enc

Lưu key vào secret.key

Khi chạy app, giải mã .env.enc rồi load vào biến môi trường

🛠 Bước 1: Cài thư viện
  
bash

    pip install cryptography

🔐 Bước 2: Script mã hóa .env → .env.enc
  
Tạo file: encrypt_env.py
  
python
  
    from cryptography.fernet import Fernet
    # Tạo key (chạy 1 lần)
    key = Fernet.generate_key()
    with open("secret.key", "wb") as f:
        f.write(key)
    
    # Mã hóa file .env
    with open(".env", "rb") as f:
        data = f.read()
    
    fernet = Fernet(key)
    encrypted = fernet.encrypt(data)
    
    with open(".env.enc", "wb") as f:
        f.write(encrypted)
    
    print("✅ Đã mã hóa thành công -> .env.enc")

🔒 Không bao giờ push secret.key lên Git!

🔓 Bước 3: Script giải mã .env.enc và nạp biến môi trường
  
Tạo file: load_env.py
  
python

    from cryptography.fernet import Fernet
    import os
    
    # Load key
    with open("secret.key", "rb") as f:
        key = f.read()
    
    fernet = Fernet(key)
    
    # Giải mã file .env.enc
    with open(".env.enc", "rb") as f:
        encrypted = f.read()
    
    decrypted = fernet.decrypt(encrypted).decode()
    
    # Nạp vào biến môi trường
    for line in decrypted.splitlines():
        if "=" in line:
            k, v = line.strip().split("=", 1)
            os.environ[k] = v
    
    # Kiểm tra
    print("🔑 VAULT_TOKEN =", os.environ.get("VAULT_TOKEN"))

✅ Bước 4: Cách dùng trong app của bạn
  
Trong script chính của bạn, chỉ cần gọi load_env.py trước khi dùng biến:

python

    import load_env  # sẽ nạp tất cả biến môi trường từ .env.enc
    import os
    from dotenv import load_dotenv
    import os, requests
    
    print("🔐 Token =", os.getenv("VAULT_TOKEN"))
    
    load_dotenv()  # Load từ .env
    
    VAULT_ADDR = "http://127.0.0.1:8200"
    VAULT_TOKEN = os.getenv("VAULT_TOKEN")
    SECRET_PATH = "secret/data/api"
    
    headers = {"X-Vault-Token": VAULT_TOKEN}
    url = f"{VAULT_ADDR}/v1/{SECRET_PATH}"
    res = requests.get(url, headers=headers)
    
    if res.status_code == 200:
        API_KEY = res.json()["data"]["data"]["api_key"]
        print(f"API_KEY = {API_KEY}")
    else:
        print(f"Error: {res.status_code} - {res.text}")


📦 Gợi ý bảo mật
  
✅ Bỏ .env, .env.enc, secret.key vào .gitignore nếu không muốn push lên Git

✅ Chia sẻ secret.key thủ công nếu cần cho máy khác (hoặc không chia luôn)

✅ Nếu nhiều người dùng máy, cân nhắc phân quyền file chmod 600 secret.key
