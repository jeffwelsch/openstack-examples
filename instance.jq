#!/usr/bin/env sh 

JSON=`jq -n ".auth.passwordCredentials.password = \"$OS_PASSWORD\" | .auth.passwordCredentials.username = \"$OS_USERNAME\" | .auth.tenantName = \"$OS_TENANT_NAME\""`
CREDS=`curl -s "$OS_AUTH_URL/tokens" -X POST -H "Content-Type: application/json" -d "$JSON"`

TOKEN=`echo $CREDS | jq -r .access.token.id`
TENANT_ID=`echo $CREDS | jq -r .access.token.tenant.id`
ENDPOINT=`echo $CREDS | jq -r '.access.serviceCatalog[] | select(.type == "compute").endpoints[0].publicURL'`

INSTANCE_NAME="test_instance"
IMAGE="6c1f5c16-4315-4f5d-a837-732c547b5cc6"
FLAVOR="n1.small"

INSTANCE_ID=`curl -s $ENDPOINT/servers \
-X POST -H "X-Auth-Project-Id: $TENANT_ID" \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "X-Auth-Token: $TOKEN" \
-d '{"server": {"name": "'$INSTANCE_NAME'", "imageRef": "'$IMAGE'", "flavorRef": "'$FLAVOR'"}}' | jq -r '. | .server.id'`

echo "Instance ID:\t" $INSTANCE_ID
curl -s $ENDPOINT/servers  -H "X-Auth-Token: $TOKEN" | jq '. | {server: .servers[].id}'
echo "Deleting instance " $INSTANCE_ID
curl -s $ENDPOINT/servers/$INSTANCE_ID -X DELETE  -H "X-Auth-Project-Id: jeffwelsch-Home" -H "X-Auth-Token: $TOKEN"
sleep 1
curl -s $ENDPOINT/servers  -H "X-Auth-Token: $TOKEN" | jq '. | {server: .servers[].id}'
