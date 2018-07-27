FROM openshift/base-centos7:latest
LABEL maintainer="Krasimir Dzhigovechki"
# install java
RUN yum update -y \
  && yum -y install unzip \
  && yum -y install java-1.8.0-openjdk-devel \
  && yum clean all

# configure java
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0
ENV PATH="$PATH:/${JAVA_HOME}/bin:.:"
# install payara
ENV PAYARA_ARCHIVE=payara41
ENV INSTALL_DIR=/opt
RUN curl -o ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -L https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.2.181/payara-4.1.2.181.zip \
  && unzip ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip -d /opt \
  && rm ${INSTALL_DIR}/${PAYARA_ARCHIVE}.zip

# configure payara
ENV DOMAIN_NAME=domain1
ENV PAYARA_HOME=${INSTALL_DIR}/payara41/glassfish
ENV DEPLOYMENT_DIR=${PAYARA_HOME}/domains/${DOMAIN_NAME}/autodeploy/
WORKDIR /opt/payara41/glassfish/bin
# expose ports

EXPOSE 4848 8009 8080 8181
#EXPOSE 8080

# deploy application
ADD target/*.war ${DEPLOYMENT_DIR}
# ensure accesss for openshift user

RUN chgrp -R 0 /opt/payara41 && \
    chmod -R g+rw /opt/payara41 && \
    find /opt/payara41 -type d -exec chmod g+x {} +

# start payara
ENTRYPOINT asadmin start-domain --verbose ${DOMAIN_NAME}