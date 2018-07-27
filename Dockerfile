FROM payara/server-full:181

##RUN ${PAYARA_PATH}/bin/asadmin start-domain ${PAYARA_DOMAIN} && \
#	${PAYARA_PATH}/bin/asadmin --user admin --passwordfile /opt/pwdfile set	server-config.java-config.debug-enabled=true

COPY ./target/*.war $DEPLOY_DIR

#EXPOSE 9009