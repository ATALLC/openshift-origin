Param([string]$path, [string]$file)
((Get-Content -path "$($path)/$($file)" -Raw) -creplace "Enable-AzureRmAlias", "#Enable-AzureRmAlias") | Set-Content -Path "$($path)/$($file)"