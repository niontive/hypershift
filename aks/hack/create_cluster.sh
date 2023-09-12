#!/bin/bash

./bin/hypershift create cluster azure \
                --base-domain hypershift.azurequickstart.org \
                --pull-secret pull-secret.txt \
                --name niontive-cluster \
                --azure-creds credentials.txt                