#!/bin/bash
argo delete -n openstack wf-keystone-bootstrap
argo delete -n openstack wf-keystone-api
argo delete -n openstack wf-mariadb
argo delete -n openstack wf-memcached
argo delete -n openstack wf-rabbitmq
