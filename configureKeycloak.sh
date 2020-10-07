#!/bin/bash

export HOME=/opt/jboss; cd /opt/jboss/keycloak/bin/ || { echo "Unable to find 'bin' directory for keycloak kcadm.sh"; exit 1; }
./kcadm.sh config credentials --server http://0.0.0.0:8080/auth --realm master --user admin --password admin
# --config=${HOME}/.keycloak/kcadm.config
./kcadm.sh create realms -s realm=demorealm -s enabled=true -o
CID=$(./kcadm.sh create clients -r demorealm -s clientId=react -s 'publicClient=true' -s 'redirectUris=["https://che-test2.apps-crc.testing/*"]' -i)

USER_ID=$(./kcadm.sh create users -r demorealm -s username=john -s enabled=true -i)
# Update password
./kcadm.sh set-password -r demorealm --username john --new-password logos

# && $script set-password   -r '$keycloakRealm' --username admin \
#                                         --new-password admin \

# /opt/jboss/keycloak/bin/kcadm.sh create identity-provider/instances -r che -s alias=openshift-v4 -s providerId=openshift-v4 -s enabled=true -s storeToken=true -s addReadTokenRoleOnCreate=true -s config.useJwksUrl=true -s config.clientId=eclipse-che-openshift-identity-provider-glqfb6 -s config.clientSecret=zDUCWU6YOZzW -s config.baseUrl=https://api.crc.testing:6443 -s config.defaultScope=user:full
./kcadm.sh create identity-provider/instances -r demorealm -s alias=openshift-v4 -s providerId=openshift-v4 -s enabled=true -s storeToken=true -s addReadTokenRoleOnCreate=true -s config.useJwksUrl=true -s config.clientId=js-adapter-identity-provider -s config.clientSecret=BraveBRxZDG3 -s config.baseUrl=https://api.crc.testing:6443 -s config.defaultScope=user:full

./kcadm.sh add-roles  -r demorealm --uusername john  --cclientid broker --rolename read-token
CLIENT_ID=$(./kcadm.sh get clients -r demorealm -q clientId=broker | sed -n 's/.*"id" *: *"\([^"]\+\).*/\1/p')
./kcadm.sh update clients/$CLIENT_ID -r demorealm -s "defaultRoles+=read-token"
