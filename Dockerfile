## -*- docker-image-name: "banno/hbase-standalone" -*-
FROM ubuntu
MAINTAINER antonio@tradingeconomics.com

# install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y python-software-properties curl

# install java
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

# install hbase master
RUN mkdir /opt/hbase
RUN wget -q http://mirrors.fe.up.pt/pub/apache/hbase/stable/hbase-0.98.9-hadoop2-bin.tar.gz | tar xfvz -C /opt/hbase
# ADD hbase-site.xml /etc/hbase/conf/hbase-site.xml

# need this for hbase to run
ENV JAVA_HOME /usr

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

CMD /opt/hbase/bin/hbase master start
