#!/bin/bash

PROJECT_NAME='rb-jenkins'

function log {
  printf "\n\n*** $1\n\n"
}

function build_jenkins_image {
  docker build -t quay.io/elostech/rb-jenkins:latest .
}

function push_jenkins_image {
  docker push quay.io/elostech/rb-jenkins:latest
}

function create_project {
  log "Creating project $PROJECT_NAME"

  oc new-project $PROJECT_NAME
}

function deploy_jenkins {
  log "Deploying jenkins"

  #oc new-app \
  #  -e OPENSHIFT_ENABLE_OAUTH=false \
  #  -e VOLUME_CAPACITY=10Gi \
  #  jenkins-ephemeral

  oc new-app \
    --name jenkins \
    -f jenkins-template.yaml
    #--docker-image=openshift/jenkins-2-centos7

  #oc expose svc jenkins

  # INFO: Completed initialization
}

function create_pipeline_job {
  oc apply -f pipeline-buildconfig.yaml
  oc start-build nodejs-sample-pipeline
}

function cleanup {
  log "Cleanup..."

  oc delete project $PROJECT_NAME

  for i in $(seq 1 10); do
    oc get project $PROJECT_NAME &>/dev/null || break
    echo "Waiting for project termination.."
    sleep 5
  done
}

#build_jenkins_image
#push_jenkins_image

cleanup
create_project
deploy_jenkins
oc get pod -w
# create_pipeline_job
