Param([string]$path, [string]$san, [string]$sak, [string]$cn)

Enable-AzureRmAlias

#create context
$ctx = New-AzureStorageContext -StorageAccountName $san -StorageAccountKey $sak

if (!(Get-AzureStorageContainer -Context $ctx | Where-Object { $_.Name -eq $cn })){
    #create container
    New-AzureStorageContainer -Name $cn -Context $ctx -Permission Off
}

$container = Get-AzureStorageContainer -Name $cn -Context $ctx
$container.CloudBlobContainer.Uri.AbsoluteUri

#assets to stage
$ansibleRPMsArchive = "ansible-rpms.tar"
$openshiftOriginRPMsArchive = "openshift-origin-rpms.tar"
$openshiftAnsibleArchive = "openshift-ansible.tar"
$openshiftContainerPlatformPlaybooksArchive = "openshift-container-platform-playbooks.tar"

$clusternodeJson = "clusternode.json"
$openshiftdeployJson = "openshiftdeploy.json"

$deployOpenShiftSh = "deployOpenShift.sh"
$masterPrepSh = "masterPrep.sh"
$nodePrepSh = "nodePrep.sh"
$infraPrepSh = "infraPrep.sh"

$masterImagesArchive = "master-images.tar"
$nodeImagesArchive = "node-images.tar"
$infraImagesArchive1 = "infra-images1.tar"
$infraImagesArchive2 = "infra-images2.tar"
$infraImagesArchive3 = "infra-images3.tar"
$infraLoggingArchive = "infra-logging-images.tar"
$infraMetricsArchive = "infra-metrics-images.tar"

$openshiftOriginArchive = "openshift-origin.tar"

#upload assets
$aoutput = "Uploading $($path)/$($ansibleRPMsArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($ansibleRPMsArchive)"
Write-Output $aoutput
Set-AzureStorageBlobContent -File "$($path)/$($ansibleRPMsArchive)" -Container $container.Name -Blob $ansibleRPMsArchive -Context $ctx -Force:$Force | Out-Null
$ooroutput = "Uploading $($path)/$($openshiftOriginRPMsArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginRPMsArchive)"
Write-Output $ooroutput
Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginRPMsArchive)" -Container $container.Name -Blob $openshiftOriginRPMsArchive -Context $ctx -Force:$Force | Out-Null
$oaoutput = "Uploading $($path)/$($openshiftAnsibleArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftAnsibleArchive)"
Write-Output $oaoutput
Set-AzureStorageBlobContent -File "$($path)/$($openshiftAnsibleArchive)" -Container $container.Name -Blob $openshiftAnsibleArchive -Context $ctx -Force:$Force | Out-Null
$ocppoutput = "Uploading $($path)/$($openshiftContainerPlatformPlaybooksArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftContainerPlatformPlaybooksArchive)"
Write-Output $ocppoutput
Set-AzureStorageBlobContent -File "$($path)/$($openshiftContainerPlatformPlaybooksArchive)" -Container $container.Name -Blob $openshiftContainerPlatformPlaybooksArchive -Context $ctx -Force:$Force | Out-Null

$cnjoutput = "Uploading $($path)/nested/$($clusternodeJson) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($clusternodeJson)"
Write-Output $cnjoutput
Set-AzureStorageBlobContent -File "$($path)/nested/$($clusternodeJson)" -Container $container.Name -Blob $clusternodeJson -Context $ctx -Force:$Force | Out-Null
$odjoutput = "Uploading $($path)/nested/$($openshiftdeployJson) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftdeployJson)"
Write-Output $odjoutput
Set-AzureStorageBlobContent -File "$($path)/nested/$($openshiftdeployJson)" -Container $container.Name -Blob $openshiftdeployJson -Context $ctx -Force:$Force | Out-Null

$doshoutput = "Uploading $($path)/scripts/$($deployOpenShiftSh) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($deployOpenShiftSh)"
Write-Output $doshoutput
Set-AzureStorageBlobContent -File "$($path)/scripts/$($deployOpenShiftSh)" -Container $container.Name -Blob $deployOpenShiftSh -Context $ctx -Force:$Force | Out-Null
$mpshoutput = "Uploading $($path)/scripts/$($masterPrepSh) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($masterPrepSh)"
Write-Output $mpshoutput
Set-AzureStorageBlobContent -File "$($path)/scripts/$($masterPrepSh)" -Container $container.Name -Blob $masterPrepSh -Context $ctx -Force:$Force | Out-Null
$npshputput = "Uploading $($path)/scripts/$($nodePrepSh) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($nodePrepSh)"
Write-Output $npshputput
Set-AzureStorageBlobContent -File "$($path)/scripts/$($nodePrepSh)" -Container $container.Name -Blob $nodePrepSh -Context $ctx -Force:$Force | Out-Null
$ipshputput = "Uploading $($path)/scripts/$($infraPrepSh) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraPrepSh)"
Write-Output $ipshputput
Set-AzureStorageBlobContent -File "$($path)/scripts/$($infraPrepSh)" -Container $container.Name -Blob $infraPrepSh -Context $ctx -Force:$Force | Out-Null

$miaoutput = "Uploading $($path)/$($masterImagesArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($masterImagesArchive)"
Write-Output $miaoutput
Set-AzureStorageBlobContent -File "$($path)/$($masterImagesArchive)" -Container $container.Name -Blob $masterImagesArchive -Context $ctx -Force:$Force | Out-Null
$niaoutput = "Uploading $($path)/$($nodeImagesArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($nodeImagesArchive)"
Write-Output $niaoutput
Set-AzureStorageBlobContent -File "$($path)/$($nodeImagesArchive)" -Container $container.Name -Blob $nodeImagesArchive -Context $ctx -Force:$Force | Out-Null
$i1iaoutput = "Uploading $($path)/$($infraImagesArchive1) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraImagesArchive1)"
Write-Output $i1iaoutput
Set-AzureStorageBlobContent -File "$($path)/$($infraImagesArchive1)" -Container $container.Name -Blob $infraImagesArchive1 -Context $ctx -Force:$Force | Out-Null
$i2iaoutput = "Uploading $($path)/$($infraImagesArchive2) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraImagesArchive2)"
Write-Output $i2iaoutput
Set-AzureStorageBlobContent -File "$($path)/$($infraImagesArchive2)" -Container $container.Name -Blob $infraImagesArchive2 -Context $ctx -Force:$Force | Out-Null
$i3iaoutput = "Uploading $($path)/$($infraImagesArchive3) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraImagesArchive3)"
Write-Output $i3iaoutput
Set-AzureStorageBlobContent -File "$($path)/$($infraImagesArchive3)" -Container $container.Name -Blob $infraImagesArchive3 -Context $ctx -Force:$Force | Out-Null
$iliaoutput = "Uploading $($path)/$($infraLoggingArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraLoggingArchive)"
Write-Output $iliaoutput
Set-AzureStorageBlobContent -File "$($path)/$($infraLoggingArchive)" -Container $container.Name -Blob $infraLoggingArchive -Context $ctx -Force:$Force | Out-Null
$imiaoutput = "Uploading $($path)/$($infraMetricsArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($infraMetricsArchive)"
Write-Output $imiaoutput
Set-AzureStorageBlobContent -File "$($path)/$($infraMetricsArchive)" -Container $container.Name -Blob $infraMetricsArchive -Context $ctx -Force:$Force | Out-Null

$ooaoutput = "Uploading $($path)/$($openshiftOriginArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginArchive)"
Write-Output $oonioutput
Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginArchive)" -Container $container.Name -Blob $openshiftOriginArchive -Context $ctx -Force:$Force | Out-Null

#generate download links
$containerURI = "https://" + $san + ".blob.core.usgovcloudapi.net/" + $cn + "/"
$startTime = Get-Date
$endTime = $startTime.AddHours(2.0)

$ansibleSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $ansibleRPMsArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$ansibleLink = "$($containerURI)$($ansibleRPMsArchive)$($ansibleSAS)"
$ansibleLink | Out-File $path/scripts/ANSIBLE_LINK.txt -NoNewline
$openshiftOriginRPMsSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginRPMsArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginRPMsLink = "$($containerURI)$($openshiftOriginRPMsArchive)$($openshiftOriginRPMsSAS)"
$openshiftOriginRPMsLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_RPMS_LINK.txt -NoNewline
$openshiftAnsibleSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftAnsibleArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftAnsibleLink = "$($containerURI)$($openshiftAnsibleArchive)$($openshiftAnsibleSAS)"
$openshiftAnsibleLink | Out-File $path/scripts/OPENSHIFT_ANSIBLE_LINK.txt -NoNewline
$openshiftContainerPlatformPlaybooksSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftContainerPlatformPlaybooksArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftContainerPlatformPlaybooksLink = "$($containerURI)$($openshiftContainerPlatformPlaybooksArchive)$($openshiftContainerPlatformPlaybooksSAS)"
$openshiftContainerPlatformPlaybooksLink | Out-File $path/scripts/OPENSHIFT_CONTAINER_PLATFORM_PLAYBOOKS_LINK.txt -NoNewline

$clusternodeJsonSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $clusternodeJson -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$clusternodeJsonLink = "$($containerURI)$($clusternodeJson)$($clusternodeJsonSAS)"
$clusternodeJsonLink | Out-File $path/scripts/CLUSTERNODE_JSON_LINK.txt -NoNewline
$openshiftdeployJsonSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftdeployJson -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftdeployJsonLink = "$($containerURI)$($openshiftdeployJson)$($openshiftdeployJsonSAS)"
$openshiftdeployJsonLink | Out-File $path/scripts/OPENSHIFT_DEPLOY_JSON_LINK.txt -NoNewline

$deployOpenShiftShSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $deployOpenShiftSh -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$deployOpenShiftShLink = "$($containerURI)$($deployOpenShiftSh)$($deployOpenShiftShSAS)"
$deployOpenShiftShLink | Out-File $path/scripts/DEPLOY_OPENSHIFT_SH_LINK.txt -NoNewline
$masterPrepShSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $masterPrepSh -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$masterPrepShLink = "$($containerURI)$($masterPrepSh)$($masterPrepShSAS)"
$masterPrepShLink | Out-File $path/scripts/MASTER_PREP_SH_LINK.txt -NoNewline
$nodePrepShSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $nodePrepSh -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$nodePrepShLink = "$($containerURI)$($nodePrepSh)$($nodePrepShSAS)"
$nodePrepShLink | Out-File $path/scripts/NODE_PREP_SH_LINK.txt -NoNewline
$infraPrepShSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraPrepSh -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraPrepShLink = "$($containerURI)$($infraPrepSh)$($infraPrepShSAS)"
$infraPrepShLink | Out-File $path/scripts/INFRA_PREP_SH_LINK.txt -NoNewline

$masterImagesArchiveSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $masterImagesArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$masterImagesArchiveLink = "$($containerURI)$($masterImagesArchive)$($masterImagesArchiveSAS)"
$masterImagesArchiveLink | Out-File $path/scripts/MASTER_IMAGES_LINK.txt -NoNewline
$nodeImagesArchiveSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $nodeImagesArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$nodeImagesArchiveLink = "$($containerURI)$($nodeImagesArchive)$($nodeImagesArchiveSAS)"
$nodeImagesArchiveLink | Out-File $path/scripts/NODE_IMAGES_LINK.txt -NoNewline
$infraImagesArchive1SAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraImagesArchive1 -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraImagesArchive1Link = "$($containerURI)$($infraImagesArchive1)$($infraImagesArchive1SAS)"
$infraImagesArchive1Link | Out-File $path/scripts/INFRA_1_IMAGES_LINK.txt -NoNewline
$infraImagesArchive2SAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraImagesArchive2 -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraImagesArchive2Link = "$($containerURI)$($infraImagesArchive2)$($infraImagesArchive2SAS)"
$infraImagesArchive2Link | Out-File $path/scripts/INFRA_2_IMAGES_LINK.txt -NoNewline
$infraImagesArchive3SAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraImagesArchive3 -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraImagesArchive3Link = "$($containerURI)$($infraImagesArchive3)$($infraImagesArchive3SAS)"
$infraImagesArchive3Link | Out-File $path/scripts/INFRA_3_IMAGES_LINK.txt -NoNewline
$infraLoggingArchiveSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraLoggingArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraLoggingArchiveLink = "$($containerURI)$($infraLoggingArchive)$($infraLoggingArchiveSAS)"
$infraLoggingArchiveLink | Out-File $path/scripts/INFRA_LOGGING_IMAGES_LINK.txt -NoNewline
$infraMetricsArchiveSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $infraMetricsArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$infraMetricsArchiveLink = "$($containerURI)$($infraMetricsArchive)$($infraMetricsArchiveSAS)"
$infraMetricsArchiveLink | Out-File $path/scripts/INFRA_METRICS_IMAGES_LINK.txt -NoNewline