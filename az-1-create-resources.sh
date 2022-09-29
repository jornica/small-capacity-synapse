#!/bin/bash
az deployment sub create --template-file createResources.bicep --confirm-with-what-if  --parameters @createResources.parameters.json
