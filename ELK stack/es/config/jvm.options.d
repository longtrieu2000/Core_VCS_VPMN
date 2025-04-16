# JVM heap size (thay đổi tùy vào hệ thống)
-Xms2g
-Xmx2g

# Garbage Collector settings (dành cho JVM 11+)
-XX:+UseG1GC
-XX:InitiatingHeapOccupancyPercent=75
-XX:+ExplicitGCInvokesConcurrent

# Log GC hoạt động
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-XX:+PrintTenuringDistribution
-XX:+PrintGCApplicationStoppedTime
-XX:+PrintGCApplicationConcurrentTime
-Xloggc:/var/log/jvm_gc.log

# Debugging
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=/var/log/heapdump.hprof

# JMX monitoring
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.port=9010
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false

# Other performance tuning
-XX:+OptimizeStringConcat
-XX:+UseStringDeduplication
