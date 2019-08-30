Param([string]$path)
$ansibleLink = [IO.File]::ReadAllText("${path}/scripts/ANSIBLE_LINK.txt")
Write-Output "$($ansibleLink)"
Write-Host "##vso[task.setvariable variable=ANSIBLE_URI]'$($ansibleLink)'"

$openshiftOriginRpmsLink = [IO.File]::ReadAllText("${path}/scripts/OPENSHIFT_ORIGIN_RPMS_LINK.txt")
Write-Output "$($openshiftOriginRpmsLink)"
Write-Host "##vso[task.setvariable variable=OPENSHIFT_ORIGIN_RPMS_URI]'$($openshiftOriginRpmsLink)'"

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

$infraPrepShLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_PREP_SH_LINK.txt")
Write-Output "$($infraPrepShLink)"
Write-Host "##vso[task.setvariable variable=INFRA_PREP_SH_URI]'$($infraPrepShLink)'"

$dockerPrepShLink = [IO.File]::ReadAllText("${path}/scripts/DOCKER_PREP_SH_LINK.txt")
Write-Output "$($dockerPrepShLink)"
Write-Host "##vso[task.setvariable variable=DOCKER_PREP_SH_URI]'$($dockerPrepShLink)'"

$masterImagesLink = [IO.File]::ReadAllText("${path}/scripts/MASTER_IMAGES_LINK.txt")
Write-Output "$($masterImagesLink)"
Write-Host "##vso[task.setvariable variable=MASTER_IMAGES_URI]'$($masterImagesLink)'"

$nodeImagesLink = [IO.File]::ReadAllText("${path}/scripts/NODE_IMAGES_LINK.txt")
Write-Output "$($nodeImagesLink)"
Write-Host "##vso[task.setvariable variable=NODE_IMAGES_URI]'$($nodeImagesLink)'"

$infra1ImagesLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_1_IMAGES_LINK.txt")
Write-Output "$($infra1ImagesLink)"
Write-Host "##vso[task.setvariable variable=INFRA_1_IMAGES_URI]'$($infra1ImagesLink)'"

$infra2ImagesLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_2_IMAGES_LINK.txt")
Write-Output "$($infra2ImagesLink)"
Write-Host "##vso[task.setvariable variable=INFRA_2_IMAGES_URI]'$($infra2ImagesLink)'"

$infra3ImagesLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_3_IMAGES_LINK.txt")
Write-Output "$($infra3ImagesLink)"
Write-Host "##vso[task.setvariable variable=INFRA_3_IMAGES_URI]'$($infra3ImagesLink)'"

$infraLoggingImagesLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_LOGGING_IMAGES_LINK.txt")
Write-Output "$($infraLoggingImagesLink)"
Write-Host "##vso[task.setvariable variable=INFRA_LOGGING_IMAGES_URI]'$($infraLoggingImagesLink)'"

$infraMetricsImagesLink = [IO.File]::ReadAllText("${path}/scripts/INFRA_METRICS_IMAGES_LINK.txt")
Write-Output "$($infraMetricsImagesLink)"
Write-Host "##vso[task.setvariable variable=INFRA_METRICS_IMAGES_URI]'$($infraMetricsImagesLink)'"

$registryImageLink = [IO.File]::ReadAllText("${path}/scripts/REGISTRY_IMAGE_LINK.txt")
Write-Output "$($registryImageLink)"
Write-Host "##vso[task.setvariable variable=REGISTRY_IMAGE_URI]'$($registryImageLink)'"

$regCertLink = [IO.File]::ReadAllText("${path}/scripts/REG_CERT_LINK.txt")
Write-Output "$($regCertLink)"
Write-Host "##vso[task.setvariable variable=REG_CERT_URI]'$($regCertLink)'"

$regKeyLink = [IO.File]::ReadAllText("${path}/scripts/REG_KEY_LINK.txt")
Write-Output "$($regKeyLink)"
Write-Host "##vso[task.setvariable variable=REG_KEY_URI]'$($regKeyLink)'"