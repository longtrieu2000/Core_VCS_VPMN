import argparse
import os
from cryptography.fernet import Fernet
import subprocess


KEY_FILE = "secret.key"
ENV_FILE = ".env"
ENC_FILE = ".env.enc"


def generate_key():
    if not os.path.exists(KEY_FILE):
        key = Fernet.generate_key()
        with open(KEY_FILE, "wb") as f:
            f.write(key)
        print("✅ Đã tạo secret.key")
    else:
        print("ℹ️  Đã có secret.key")


def load_key():
    with open(KEY_FILE, "rb") as f:
        return f.read()


def encrypt_env():
    if not os.path.exists(ENV_FILE):
        print("❌ Không tìm thấy .env để mã hóa.")
        return
    key = load_key()
    fernet = Fernet(key)
    with open(ENV_FILE, "rb") as f:
        data = f.read()
    encrypted = fernet.encrypt(data)
    with open(ENC_FILE, "wb") as f:
        f.write(encrypted)
    print("✅ Đã mã hóa .env -> .env.enc")


def decrypt_env():
    if not os.path.exists(ENC_FILE):
        print("❌ Không tìm thấy .env.enc để giải mã.")
        return
    key = load_key()
    fernet = Fernet(key)
    with open(ENC_FILE, "rb") as f:
        encrypted = f.read()
    decrypted = fernet.decrypt(encrypted)
    with open(ENV_FILE, "wb") as f:
        f.write(decrypted)
    print("✅ Đã giải mã .env.enc -> .env")


def edit_env():
    decrypt_env()
    editor = os.environ.get("EDITOR", "nano")
    subprocess.call([editor, ENV_FILE])
    encrypt_env()
    os.remove(ENV_FILE)
    print("🧹 Đã xóa .env bản rõ sau khi mã hóa lại.")


def main():
    parser = argparse.ArgumentParser(description="🔐 Quản lý .env mã hóa bằng Fernet")
    parser.add_argument("--encrypt", action="store_true", help="Mã hóa .env -> .env.enc")
    parser.add_argument("--decrypt", action="store_true", help="Giải mã .env.enc -> .env")
    parser.add_argument("--edit", action="store_true", help="Giải mã, chỉnh sửa, mã hóa lại và xóa .env")
    
    args = parser.parse_args()
    generate_key()


    if args.encrypt:
        encrypt_env()
    elif args.decrypt:
        decrypt_env()
    elif args.edit:
        edit_env()
    else:
        parser.print_help()


if __name__ == "__main__":
    main()





