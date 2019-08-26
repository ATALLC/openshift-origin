Param([string]$link)
Invoke-WebRequest -Uri "$($link)" -Method GET