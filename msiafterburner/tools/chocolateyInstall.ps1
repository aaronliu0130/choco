$packageName = 'msiafterburner'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.msi.com/uti_exe/vga/MSIAfterburnerSetup.zip'

$unpackDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$unpackFile = Join-Path $unpackDir 'afterburner.zip'
$ProcessActive = Get-Process MSIAfterburner* -ErrorAction SilentlyContinue
if($ProcessActive -ne $null)
{
	Stop-Process -ProcessName MSIAfterburner*
}
Get-ChocolateyWebFile $packageName $unpackFile $url -Checksum 67C78F35D824B4C3A60035E4A5FFF3CEBF40C0F19D0195DC60925F5AB32982E5 -ChecksumType 'sha256'
Get-ChocolateyUnzip -fileFullPath $unpackFile -destination $unpackDir
$file = (Get-ChildItem -Path $unpackDir -Recurse | Where-Object {$_.Name -match "MSIAfterburnerSetup.*.exe$"}).fullname

Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file 
Remove-Item $unpackFile -Recurse -Force
Remove-Item $file -Recurse -Force