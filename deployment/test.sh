#! /bin/bash
# oc project default
oc process -f ./openshift.yaml \
    -p KEYCLOAK_USER=admin \
    -p KEYCLOAK_PASSWORD=admin \
    -p NAMESPACE=test4 \
| oc create -f -
#   | oc delete -f - 

# oc apply -f deployment.yaml
# oc expose svc js-adapter