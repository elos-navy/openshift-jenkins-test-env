FROM openshift/jenkins-2-centos7:latest

#ADD ./run /usr/libexec/s2i/runblah

ADD plugins.txt /tmp/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /tmp/plugins.txt

#RUN curl -L https://raw.githubusercontent.com/hgomez/devops-incubator/master/forge-tricks/batch-install-jenkins-plugins.sh -o /tmp/batch-install-jenkins-plugins.sh && \
#  chmod +x /tmp/batch-install-jenkins-plugins.sh && \
#  /tmp/batch-install-jenkins-plugins.sh --plugins /tmp/plugins.txt --plugindir /var/lib/jenkins/plugins/

RUN \
  echo 'envinject:latest' >> /opt/openshift/base-plugins.txt && \
  echo 'envinject-api' >> /opt/openshift/base-plugins.txt && \
  echo 'logstash' >> /opt/openshift/base-plugins.txt

ADD demo-pipeline /opt/openshift/configuration/jobs/demo-pipeline
