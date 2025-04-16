Cấu hình Heap Size
   
    -Xms2g
    -Xmx2g

-Xms2g: Đặt kích thước bộ nhớ heap ban đầu của JVM là 2GB.

-Xmx2g: Đặt kích thước tối đa của heap là 2GB.

Heap là bộ nhớ dành riêng cho JVM để quản lý object. Việc đặt giá trị -Xms và -Xmx bằng nhau giúp JVM không phải mở rộng heap động, tránh gây tốn tài nguyên.

Cấu hình Garbage Collector (GC)

    -XX:+UseG1GC
    -XX:InitiatingHeapOccupancyPercent=75
    -XX:+ExplicitGCInvokesConcurrent

-XX:+UseG1GC: Sử dụng Garbage First Garbage Collector (G1GC), là GC tối ưu cho hệ thống có heap lớn, giúp giảm thời gian dừng (pause time).

-XX:InitiatingHeapOccupancyPercent=75: Khi heap sử dụng 75%, JVM sẽ tự động kích hoạt GC.

-XX:+ExplicitGCInvokesConcurrent: Khi chương trình gọi System.gc(), thay vì dừng ứng dụng để dọn dẹp, JVM sẽ chạy GC song song với ứng dụng.

Ghi log hoạt động của Garbage Collector

    -XX:+PrintGCDetails
    -XX:+PrintGCDateStamps
    -XX:+PrintTenuringDistribution
    -XX:+PrintGCApplicationStoppedTime
    -XX:+PrintGCApplicationConcurrentTime
    -Xloggc:/var/log/jvm_gc.log

-XX:+PrintGCDetails: Hiển thị thông tin chi tiết mỗi lần GC chạy.

-XX:+PrintGCDateStamps: Ghi thời gian chính xác mỗi lần GC xảy ra.

-XX:+PrintTenuringDistribution: Hiển thị số object trong Young Generation được giữ lại bao nhiêu lâu trước khi chuyển vào Old Generation.

-XX:+PrintGCApplicationStoppedTime: Ghi log thời gian ứng dụng bị dừng do GC.

-XX:+PrintGCApplicationConcurrentTime: Ghi log thời gian ứng dụng chạy bình thường giữa các lần GC.

-Xloggc:/var/log/jvm_gc.log: Lưu log GC vào file /var/log/jvm_gc.log.

Debugging & Heap Dump

    -XX:+HeapDumpOnOutOfMemoryError
    -XX:HeapDumpPath=/var/log/heapdump.hprof

-XX:+HeapDumpOnOutOfMemoryError: Khi JVM gặp lỗi OutOfMemoryError, nó sẽ tạo một bản ghi heap dump.

-XX:HeapDumpPath=/var/log/heapdump.hprof: Lưu file dump vào /var/log/heapdump.hprof. File này có thể dùng để phân tích nguyên nhân gây tràn bộ nhớ bằng công cụ như Eclipse Memory Analyzer.

Cấu hình JMX Monitoring (Giám sát JVM từ xa)

    -Dcom.sun.management.jmxremote
    -Dcom.sun.management.jmxremote.port=9010
    -Dcom.sun.management.jmxremote.authenticate=false
    -Dcom.sun.management.jmxremote.ssl=false

-Dcom.sun.management.jmxremote: Bật JMX (Java Management Extensions) để giám sát JVM từ xa.

-Dcom.sun.management.jmxremote.port=9010: Mở cổng 9010 cho JMX kết nối từ xa.

-Dcom.sun.management.jmxremote.authenticate=false: Không yêu cầu xác thực (dùng trong môi trường nội bộ, không khuyến khích cho production).

-Dcom.sun.management.jmxremote.ssl=false: Không sử dụng SSL để đơn giản hóa cấu hình.

Các tối ưu hiệu suất khác

    -XX:+OptimizeStringConcat
    -XX:+UseStringDeduplication

-XX:+OptimizeStringConcat: JVM sẽ tối ưu hóa việc nối chuỗi (String concatenation), giúp giảm việc tạo object không cần thiết.

-XX:+UseStringDeduplication: JVM tự động phát hiện các chuỗi giống nhau trong heap memory và hợp nhất chúng, giúp giảm dung lượng sử dụng bộ nhớ.
