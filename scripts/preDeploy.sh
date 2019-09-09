#!/bin/bash

az vm encryption enable --disk-encryption-keyvault ${keyVaultName} --volume-type All
