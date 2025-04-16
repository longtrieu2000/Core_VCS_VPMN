ở đây dấu ngoặc nhọn {} và dấu cách rất quan trọng trong file config, nên lưu ý

    grok {
      match => { "message" => "%{IPORHOST:remote_addr} - %{DATA:remote_user} \[%{HTTPDATE:@timestamp}\] \"%{WORD:request_method} %{URIPATH:request_uri}(?: HTTP/%{NUMBER:http_version})?\" %{NUMBER:status:int} %          { 
      {NUMBER:body_bytes_sent} \"%{URI:http_referer}\" \"%{DATA:http_user_agent}\"" }
    }

✅ Cách upload vào Elasticsearch:

    curl -X PUT http://localhost:9200/_index_template/nginx-access-template \
         -H 'Content-Type: application/json' \
         -d @logstash_nginx_template.json
