Param([string]$path, [string]$san, [string]$sak, [string]$cn)

#Enable-AzureRmAlias

#create context
$ctx = New-AzureStorageContext -StorageAccountName $san -StorageAccountKey $sak

if (!(Get-AzureStorageContainer -Context $ctx | Where-Object { $_.Name -eq $cn })){
    #create container
    New-AzureStorageContainer -Name $cn -Context $ctx -Permission Off
}

$container = Get-AzureStorageContainer -Name $cn -Context $ctx
$container.CloudBlobContainer.Uri.AbsoluteUri

#assets to stage
$ansibleArchive = "ansible-rpms.tar"
$openshiftAnsibleArchive = "openshift-ansible.tar"
$openshiftContainerPlatformPlaybooksArchive = "openshift-container-platform-playbooks.tar"

$clusternodeJson = "clusternode.json"
$openshiftdeployJson = "openshiftdeploy.json"

$deployOpenShiftSh = "deployOpenShift.sh"
$masterPrepSh = "masterPrep.sh"
$nodePrepSh = "nodePrep.sh"

$cockpitKubernetesImage = "cockpit_kubernetes.docker"
$openshiftOriginDeployerImage = "openshift_origin-deployer.3.9.docker"
$openshiftOriginDockerRegistryImage = "openshift_origin-docker-registry.3.9.docker"
$openshiftOriginHAProxyImage = "openshift_origin-haproxy-router.3.9.docker"
$openshiftOriginPodImage = "openshift_origin-pod.3.9.docker"
$openshiftOriginNodeImage = "openshift_origin-node.docker"

$openshiftOriginArchive = "openshift-origin.tar"

#upload assets
$aoutput = "Uploading $($path)/$($ansibleArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($ansibleArchive)"
Write-Output $aoutput
Set-AzureStorageBlobContent -File "$($path)/$($ansibleArchive)" -Container $container.Name -Blob $ansibleArchive -Context $ctx -Force:$Force | Out-Null
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

#$ckioutput = "Uploading $($path)/$($cockpitKubernetesImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($cockpitKubernetesImage)"
#Write-Output $ckioutput
#Set-AzureStorageBlobContent -File "$($path)/$($cockpitKubernetesImage)" -Container $container.Name -Blob $cockpitKubernetesImage -Context $ctx -Force:$Force | Out-Null
#$oodioutput = "Uploading $($path)/$($openshiftOriginDeployerImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginDeployerImage)"
#Write-Output $oodioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginDeployerImage)" -Container $container.Name -Blob $openshiftOriginDeployerImage -Context $ctx -Force:$Force | Out-Null
#$oodrioutput = "Uploading $($path)/$($openshiftOriginDockerRegistryImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginDockerRegistryImage)"
#Write-Output $oodrioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginDockerRegistryImage)" -Container $container.Name -Blob $openshiftOriginDockerRegistryImage -Context $ctx -Force:$Force | Out-Null
#$oohpioutput = "Uploading $($path)/$($openshiftOriginHAProxyImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginHAProxyImage)"
#Write-Output $oohpioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginHAProxyImage)" -Container $container.Name -Blob $openshiftOriginHAProxyImage -Context $ctx -Force:$Force | Out-Null
#$oopioutput = "Uploading $($path)/$($openshiftOriginPodImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginPodImage)"
#Write-Output $oopioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginPodImage)" -Container $container.Name -Blob $openshiftOriginPodImage -Context $ctx -Force:$Force | Out-Null
#$oonioutput = "Uploading $($path)/$($openshiftOriginNodeImage) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginNodeImage)"
#Write-Output $oonioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginNodeImage)" -Container $container.Name -Blob $openshiftOriginNodeImage -Context $ctx -Force:$Force | Out-Null

#$ooaoutput = "Uploading $($path)/$($openshiftOriginArchive) to $($container.CloudBlobContainer.Uri.AbsoluteUri)/$($openshiftOriginArchive)"
#Write-Output $oonioutput
#Set-AzureStorageBlobContent -File "$($path)/$($openshiftOriginArchive)" -Container $container.Name -Blob $openshiftOriginArchive -Context $ctx -Force:$Force | Out-Null

#generate download links
$containerURI = "https://" + $san + ".blob.core.usgovcloudapi.net/" + $cn + "/"
$startTime = Get-Date
$endTime = $startTime.AddHours(2.0)

$ansibleSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $ansibleArchive -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$ansibleLink = "$($containerURI)$($ansibleArchive)$($ansibleSAS)"
$ansibleLink | Out-File $path/scripts/ANSIBLE_LINK.txt -NoNewline
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

$cockpitKubernetesImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $cockpitKubernetesImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$cockpitKubernetesImageLink = "$($containerURI)$($cockpitKubernetesImage)$($cockpitKubernetesImageSAS)"
$cockpitKubernetesImageLink | Out-File $path/scripts/COCKPIT_KUBERNETES_IMAGE_LINK.txt -NoNewline
$openshiftOriginDeployerImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginDeployerImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginDeployerImageLink = "$($containerURI)$($openshiftOriginDeployerImage)$($openshiftOriginDeployerImageSAS)"
$openshiftOriginDeployerImageLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_DEPLOYER_IMAGE_LINK.txt -NoNewline
$openshiftOriginDockerRegistryImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginDockerRegistryImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginDockerRegistryImageLink = "$($containerURI)$($openshiftOriginDockerRegistryImage)$($openshiftOriginDockerRegistryImageSAS)"
$openshiftOriginDockerRegistryImageLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_DOCKER_REGISTRY_IMAGE_LINK.txt -NoNewline
$openshiftOriginHAProxyImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginHAProxyImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginHAProxyImageLink = "$($containerURI)$($openshiftOriginHAProxyImage)$($openshiftOriginHAProxyImageSAS)"
$openshiftOriginHAProxyImageLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_HA_PROXY_IMAGE_LINK.txt -NoNewline
$openshiftOriginPodImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginPodImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginPodImageLink = "$($containerURI)$($openshiftOriginPodImage)$($openshiftOriginPodImageSAS)"
$openshiftOriginPodImageLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_POD_IMAGE_LINK.txt -NoNewline
$openshiftOriginNodeImageSAS = New-AzureStorageBlobSASToken -Container $cn -Blob $openshiftOriginNodeImage -Permission rwd -StartTime $startTime -ExpiryTime $endTime -Context $ctx
$openshiftOriginNodeImageLink = "$($containerURI)$($openshiftOriginNodeImage)$($openshiftOriginNodeImageSAS)"
$openshiftOriginNodeImageLink | Out-File $path/scripts/OPENSHIFT_ORIGIN_NODE_IMAGE_LINK.txt -NoNewline
