FROM jboss/keycloak:latest
LABEL maintainer "APPUiO (https://www.appuio.ch/)"

ENV JTDS_VERSION 1.3.1
ENV JTDS_URL https://repo1.maven.org/maven2/net/sourceforge/jtds/jtds/${JTDS_VERSION}/jtds-${JTDS_VERSION}.jar

COPY *.xsl /opt/jboss/keycloak/
COPY module.xml /opt/jboss/keycloak/modules/system/layers/base/net/sourceforge/jtds/main/

USER root

RUN set -x && \
  mkdir -p /opt/jboss/keycloak/modules/system/layers/base/net/sourceforge/jtds/main && \
  cd /opt/jboss/keycloak/modules/system/layers/base/net/sourceforge/jtds/main && \
  curl -sSLO $JTDS_URL && \
  echo $(curl -sSL ${JTDS_URL}.sha1) jtds-${JTDS_VERSION}.jar > shasums.txt && \
  sha1sum -c shasums.txt && \
  java -jar /usr/share/java/saxon.jar \
    -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml \
    -xsl:/opt/jboss/keycloak/changeDatabase.xsl \
    -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml && \
  java -jar /usr/share/java/saxon.jar \
    -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml \
    -xsl:/opt/jboss/keycloak/changeDatabase.xsl \
    -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
  java -jar /usr/share/java/saxon.jar \
    -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml \
    -xsl:/opt/jboss/keycloak/changeProxy.xsl \
    -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml && \
  java -jar /usr/share/java/saxon.jar \
    -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml \
    -xsl:/opt/jboss/keycloak/changeProxy.xsl \
    -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
  rm /opt/jboss/keycloak/*.xsl && \
  chown -R jboss:0 "${JBOSS_HOME}/standalone" && \
  chmod -R g+rw "${JBOSS_HOME}/standalone"

USER jboss
