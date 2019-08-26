Param([string]$path)
$paramsFile = [IO.File]::ReadAllText("${path}/azuredeploy.parameters.json")
Write-Output "$($paramsFile)"
Write-Host "$($paramsFile)"
