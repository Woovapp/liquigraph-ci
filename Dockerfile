FROM openjdk:8u171-jdk-alpine3.7

WORKDIR /usr
RUN wget http://search.maven.org/remotecontent?filepath=org/liquigraph/liquigraph-cli/2.0.2/liquigraph-cli-2.0.2-bin.tar.gz
RUN tar xzf liquigraph-cli-2.0.2-bin.tar.gz
RUN export PATH=$PATH:/usr/liquigraph-cli
WORKDIR /usr/liquigraph-cli
