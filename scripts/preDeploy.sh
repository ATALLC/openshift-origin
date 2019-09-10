#!/bin/bash

az vm encryption enable --disk-encryption-keyvault ${keyVaultName} --volume-type All

az vm list-ip-addresses --ids $(az vm list -g smartfmOpenShiftResourceGroupSEC --query "[].id" -o tsv) |grep name | awk -F '"' '{print $4}'


for n in `az vm list-ip-addresses --ids $(az vm list -g smartfmOpenShiftResourceGroupSEC --query "[].id" -o tsv) |grep name | awk -F '"' '{print $4}'`
do
  echo $n
  az keyvault set-policy --name smartfmDiskVault --key-permissions wrapKey   --secret-permissions set --spn b7600f3f-a160-4339-9b2d-d8303d12d160 --disk-encryption-keyvault smartfmDiskVault --key-encryption-key smartfmDiskKey --volume-type all
done


az keyvault set-policy --name smartfmDiskVault --spn $AAD_CLIENT_ID --key-permissions wrapKey --secret-permissions set \
    --spn $sp_id \
    --key-permissions wrapKey \
    --secret-permissions set


az keyvault set-policy --name smartfmDiskVault --key-permissions wrapKey   --secret-permissions set --spn b7600f3f-a160-4339-9b2d-d8303d12d160

    az vm encryption enable --resource-group smartfmOpenShiftResourceGroupSEC --name $n  --aad-client-id b7600f3f-a160-4339-9b2d-d8303d12d160 --aad-client-secret WM@mxa.+/4w3K6kMK1QB/y8dJ?qHqubD --disk-encryption-keyvault smartfmDiskVault --key-encryption-key smartfmDiskKey --volume-type all


    for n in `az vm list-ip-addresses --ids $(az vm list -g smartfmOpenShiftResourceGroupSEC --query "[].id" -o tsv) |grep name | awk -F '"' '{print $4}'`
    do
      echo $n
      az keyvault set-policy --name smartfmDiskVault --key-permissions wrapKey   --secret-permissions set --spn b7600f3f-a160-4339-9b2d-d8303d12d160 --disk-encryption-keyvault smartfmDiskVault --key-encryption-key smartfmDiskKey --volume-type all
    done


    for n in `az vm list-ip-addresses --ids $(az vm list -g smartfmOpenShiftResourceGroupSEC --query "[].id" -o tsv) |grep name | awk -F '"' '{print $4}'`
    do
      echo $n
      az vm encryption enable -n $n -g smartfmOpenShiftResourceGroupSEC --disk-encryption-keyvault smartfmATADevKeyVaultSEC --aad-client-id b7600f3f-a160-4339-9b2d-d8303d12d160 --aad-client-secret WM@mxa.+/4w3K6kMK1QB/y8dJ?qHqubD  --volume-type all
    done
