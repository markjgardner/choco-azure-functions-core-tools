[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$response = Invoke-WebRequest -Uri 'https://github.com/Azure/azure-functions-core-tools/releases/latest' -MaximumRedirection 0 -ErrorAction SilentlyContinue
$latest = $response.Headers.Location
$tokens = $latest.Split('/');
$version = $tokens[$tokens.Length-1]
Write-Output ("##vso[task.setvariable variable=Version;]$version")
