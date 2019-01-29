# argo-ohm
Argo POC

## Installation of kubernetes 

TBD

## Installation of keystone and associated services

TBD

## Installation of argo itself

```bash
helm fetch argo/argo
tar xvf argo.xxx.tgz
helm install --name argo --namespace argo .
```

## argo cli

### Deployment

```bash
cd keystone-argo-cli
argo submit -n openstack wf-mariadb.yaml
argo submit -n openstack wf-memcached.yaml
argo submit -n openstack wf-rabbitmq.yaml
argo submit -n openstack wf-keystone-api.yaml
argo submit -n openstack wf-keystone-bootstrap.yaml
```

```bash
argo get wf-keystone-api -n openstack
Name:                wf-keystone-api
Namespace:           openstack
ServiceAccount:      keystone-api
Status:              Succeeded
Created:             Tue Jan 29 17:19:45 -0600 (54 seconds ago)
Started:             Tue Jan 29 17:19:45 -0600 (54 seconds ago)
Finished:            Tue Jan 29 17:20:38 -0600 (1 second ago)
Duration:            53 seconds

STEP                                      PODNAME                     DURATION  MESSAGE
 ✔ wf-keystone-api
 ├---✔ svc-memcached                      wf-keystone-api-2517001386  4s
 ├---✔ svc-mariadb                        wf-keystone-api-1718994872  5s
 ├---✔ wf-keystone-db-sync
 |   ├---✔ svc-mariadb                    wf-keystone-api-3144285078  3s
 |   ├---✔ wf-keystone-db-init
 |   |   ├---✔ svc-mariadb                wf-keystone-api-1703586597  2s
 |   |   └---✔ job-keystone-db-init       wf-keystone-api-3354426817  3s
 |   ├---✔ job-keystone-credential-setup  wf-keystone-api-3324764547  3s
 |   ├---✔ job-keystone-fernet-setup      wf-keystone-api-2605329163  2s
 |   ├---✔ wf-keystone-rabbit-init
 |   |   ├---✔ svc-rabbitmq               wf-keystone-api-823436806   3s
 |   |   └---✔ job-keystone-rabbit-init   wf-keystone-api-1346041812  3s
 |   └---✔ job-keystone-db-sync           wf-keystone-api-1562708993  2s
 ├---✔ job-keystone-credential-setup      wf-keystone-api-196303985   3s
 ├---✔ job-keystone-fernet-setup          wf-keystone-api-740083775   3s
 ├---✔ wf-keystone-rabbit-init
 |   ├---✔ svc-rabbitmq                   wf-keystone-api-2519204236  2s
 |   └---✔ job-keystone-rabbit-init       wf-keystone-api-2526730454  3s
 └---✔ svc-keystone-api                   wf-keystone-api-1282227320  2s
```
### Note 1

the serviceAccountName field in the workflow is important. Each component of the openstackhelm is creating standalone serviceAccount.
I could not figure how to achieve the same level of granularity

### Note 2

Note having access to the templating language basically void the interest of the helm-toolkit. For instance dependencies in 
original helm chart, reference 

### Note 3

Approach is of such deploment is much more centralized. You don't let kubernetes do its thing anymore...aka initcontainer would
retry until dependency is resolved. Need to find the right balance between the two approaches.

### Note 4

ARGO UI is to some extend not as good as the "argo cli" and seems much slower


## Installation using helm chart

### Deployment

Argo is using a CRD pattern, so can be controlled through kubectl without using argo cli ....therefore let us helm and associated template language.

```bash
cd keystone-argo-helm
helm install --name armadalike-keystone --namespace
```

### Note 1

Not much of the workflows has been templatized in the template directory

### Note 2

The workflow 'keystone-argo-helm/templates/wf-keystone.yaml' is an attempt to simulate an airship-armada like workflow/chart group.
One workflow (equivalent of chartgroup) is basically waiting for the other worflow completed (equivalent of helm chart).
Still having with serviceAccount. Interesting aspect is that we still have access to the templating of helm as for armada

## Conclusion

TBD
