FROM openjdk:8u171-jdk-alpine3.7

WORKDIR /usr
RUN wget http://repo1.maven.org/maven2/org/liquigraph/liquigraph-cli/3.0.2/liquigraph-cli-3.0.2-bin.tar.gz
RUN tar xzf liquigraph-cli-3.0.2-bin.tar.gz
RUN export PATH=$PATH:/usr/liquigraph-cli
COPY migrate.sh /usr/liquigraph-cli/

WORKDIR /usr/liquigraph-cli
