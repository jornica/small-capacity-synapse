#!/bin/bash
az deployment group what-if --template-file cleanResourceGroup.bicep  --mode Complete
az group delete 

