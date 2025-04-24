FROM nginx:alpine
#cai openssl
RUN apk add --no-cache openssl

#Copy script/generate SSL
COPY generate-certs.sh /usr/local/bin/generate-certs.sh
RUN chmod +x /usr/local/bin/generate-certs.sh
