#!/bin/bash
argo submit -n openstack wf-mariadb.yaml
argo submit -n openstack wf-memcached.yaml
argo submit -n openstack wf-rabbitmq.yaml
argo submit -n openstack wf-keystone-api.yaml
argo submit -n openstack wf-keystone-bootstrap.yaml
