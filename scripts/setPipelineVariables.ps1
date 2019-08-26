Param([string]$path)
$ansibleLink = [IO.File]::ReadAllText("${path}/scripts/ANSIBLE_LINK.txt")
Write-Output "$($ansibleLink)"
Write-Host "##vso[task.setvariable variable=ANSIBLE_URI]'$($ansibleLink)'"

$openshiftAnsibleLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ANSIBLE_LINK.txt")
Write-Output "$($openshiftAnsibleLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ANSIBLE_URI]'$($openshiftAnsibleLink)'"

$openshiftContainerPlatformPlaybooksLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_CONTAINER_PLATFORM_PLAYBOOKS_LINK.txt")
Write-Output "$($openshiftContainerPlatformPlaybooksLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_CONTAINER_PLATFORM_PLAYBOOKS_URI]'$($openshiftContainerPlatformPlaybooksLink)'"

$clusterNodeJsonLink = [IO.File]::ReadAllText("${path}/scripts/CLUSTERNODE_JSON_LINK.txt")
Write-Output "$($clusterNodeJsonLink)"
Write-Host "##vso[task.setvariable variable=CLUSTERNODE_JSON_URI]'$($clusterNodeJsonLink)'"

$openshiftDeployJsonLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_DEPLOY_JSON_LINK.txt")
Write-Output "$($openshiftDeployJsonLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_DEPLOY_JSON_URI]'$($openshiftDeployJsonLink)'"

$deployOpenshiftShLink = [IO.File]::ReadAllText("${path}/scripts/DEPLOY_OPENSHIFT_SH_LINK.txt")
Write-Output "$($deployOpenshiftShLink)"
Write-Host "##vso[task.setvariable variable=DEPLOY_OPENSHIFT_SH_URI]'$($deployOpenshiftShLink)'"

$masterPrepShLink = [IO.File]::ReadAllText("${path}/scripts/MASTER_PREP_SH_LINK.txt")
Write-Output "$($masterPrepShLink)"
Write-Host "##vso[task.setvariable variable=MASTER_PREP_SH_URI]'$($masterPrepShLink)'"

$nodePrepShLink = [IO.File]::ReadAllText("${path}/scripts/NODE_PREP_SH_LINK.txt")
Write-Output "$($nodePrepShLink)"
Write-Host "##vso[task.setvariable variable=NODE_PREP_SH_URI]'$($nodePrepShLink)'"

$cockpitKubernetesImageLink = [IO.File]::ReadAllText("${path}/scripts/COCKPIT_KUBERNETES_IMAGE_LINK.txt")
Write-Output "$($cockpitKubernetesImageLink)"
Write-Host "##vso[task.setvariable variable=COCKPIT_KUBERNETES_IMAGE_URI]'$($cockpitKubernetesImageLink)'"

$openshiftOriginDeployerImageLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_DEPLOYER_IMAGE_LINK.txt")
Write-Output "$($openshiftOriginDeployerImageLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_DEPLOYER_IMAGE_URI]'$($openshiftOriginDeployerImageLink)'"

$openshiftOriginDockerRegistryImageLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_DOCKER_REGISTRY_IMAGE_LINK.txt")
Write-Output "$($openshiftOriginDockerRegistryImageLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_DOCKER_REGISTRY_IMAGE_URI]'$($openshiftOriginDockerRegistryImageLink)'"

$openshiftOriginHAProxyImageLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_HA_PROXY_IMAGE_LINK.txt")
Write-Output "$($openshiftOriginHAProxyImageLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_HA_PROXY_IMAGE_URI]'$($openshiftOriginHAProxyImageLink)'"

$openshiftOriginPodImageLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_POD_IMAGE_LINK.txt")
Write-Output "$($openshiftOriginPodImageLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_POD_IMAGE_URI]'$($openshiftOriginPodImageLink)'"

$openshiftOriginNodeImageLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_NODE_IMAGE_LINK.txt")
Write-Output "$($openshiftOriginNodeImageLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_NODE_IMAGE_URI]'$($openshiftOriginNodeImageLink)'"