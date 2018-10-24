FROM centos:7.5.1804
maintainer only server888@yeah.net
# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/usr/java/jdk
ENV CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
ENV PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOMR/bin
ENV ZK_HOME /usr/local/fn/zookeeper

RUN mkdir -p /usr/java/ && \
    yum install -y wget && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz" && \
    tar zvxf jdk-8u141-linux-x64.tar.gz -C /usr/java/  && \
    rm -f jdk-8u141-linux-x64.tar.gz && \
    mv /usr/java/jdk1.8.0_141  /usr/java/jdk && \
    mkdir -p /usr/local/fn && \
    cd /usr/local/fn/  && \
   wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz && \
   tar zxvf zookeeper-3.4.9.tar.gz -C /usr/local/fn/ && \
   ln -s /usr/local/fn/zookeeper-3.4.9 ${ZK_HOME}

EXPOSE 2181

ENTRYPOINT ["/usr/local/fn/zookeeper/bin/zkServer.sh","start-foreground","/etc/fn/zookeeper/zoo.cfg"]
