$ErrorActionPreference = 'Stop';
 
$packageName= 'azure-functions-core-tools.multiarch'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/Azure/azure-functions-core-tools/releases/download/#{toolsVersion}#/Azure.Functions.Cli.win-x86.#{toolsVersion}#.zip'
$checksum   = '#{checksumx86}#'
$url64bit   = 'https://github.com/Azure/azure-functions-core-tools/releases/download/#{toolsVersion}#/Azure.Functions.Cli.win-x64.#{toolsVersion}#.zip'
$checksum   = '#{checksumx64}#'
 
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = $url
  checksum       = $checksum
  checksumType   = 'SHA256'
  url64bit       = $url64bit
  checksum64     = $checksum64
  checksumType64 = 'SHA256'
}
 
Install-ChocolateyZipPackage @packageArgs
 
# only symlink for func.exe
$files = get-childitem $toolsDir -include *.exe -recurse
foreach ($file in $files) {
  if (!$file.Name.Equals("func.exe")) {
    #generate an ignore file
    New-Item "$file.ignore" -type file -force | Out-Null
  }
}