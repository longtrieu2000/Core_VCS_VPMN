Ở đây dùng docker-compose để triển khai mô hình ELK bao gồm: Filebeat lấy log gửi đển logstash, logstash chịu trách nhiệm thu nhập log, filter gắn tag rồi gửi dến elasticsearch lưu trữ. Chúng ta xem nó qua Kibana bằng các file index

Lưu ý ở Filebeat triển khai bằng docker sẽ lấy log trong nó, nên cần ánh xạ file log ở ngoài vào và gửi log đi
