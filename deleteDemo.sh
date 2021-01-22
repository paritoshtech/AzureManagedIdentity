kubectl delete pod demo
kubectl delete azureidentity ${IDENTITY_NAME}
kubectl delete azureidentitybinding ${IDENTITY_NAME}-binding
az role assignment delete --id ${IDENTITY_ASSIGNMENT_ID}
az identity delete -g ${IDENTITY_RESOURCE_GROUP} -n ${IDENTITY_NAME}