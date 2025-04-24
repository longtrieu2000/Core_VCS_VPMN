#!/bin/sh

# Thông tin chứng chỉ
DOMAIN="elastic.vcs.vpmn jira.vcs.vpmn confluence.vcs.vpmn"
CERT_DIR="/etc/nginx/ssl"
DAYS_VALID=365
# Tạo thư mục chứa cert nếu chưa có
#mkdir -p "$CERT_DIR"

# Tạo chứng chỉ tự ký
for MAIN in $DOMAIN; do
    echo "$MAIN"
    KEY_FILE="$CERT_DIR/$DOMAIN.key"
    CERT_FILE="$CERT_DIR/$DOMAIN.crt"
    openssl req -x509 -nodes -days "$DAYS_VALID" \
    -newkey rsa:2048 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/C=VN/ST=HCM/L=HCM/O=MyCompany/OU=IT/CN=$MAIN"

    # Phân quyền file private key
    chmod 600 "$KEY_FILE"

    # Thông báo hoàn tất
    echo "✅ Self-signed SSL certificate đã được tạo:"
    echo "🔒 Key:  $KEY_FILE"
    echo "📄 Cert: $CERT_FILE"
done
