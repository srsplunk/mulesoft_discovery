#/bin/bash

if [ "$#" -ne 2 ]
then
	echo "Enter the username and password on the command line"
	echo "Example:"
	echo "./discover.sh myMulesoftUser pa55word"
	exit 1
fi

#Get The Access Token
accessToken=$(curl -k https://anypoint.mulesoft.com/accounts/login -X POST --data "username=${1}&password=${2}" 2>/dev/null | jq -r .access_token)

echo Access Token
echo ============
echo $accessToken
echo
#exit 0
#Get the Organization ID
orgId=$(curl -H "Authorization: Bearer ${accessToken}" https://anypoint.mulesoft.com/accounts/api/me 2>/dev/null| jq -r .user.organization.id) 

echo Organization Id
echo ===============
echo $orgId
echo

#Get the Environments
envIds=$(curl -H "Authorization: Bearer ${accessToken}" https://anypoint.mulesoft.com/accounts/api/organizations/${orgId}/environments 2>/dev/null | jq '.data[] | {name, id}')

echo Environment Ids
echo ===============
echo $envIds | jq .

