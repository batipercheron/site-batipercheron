Add-Type -AssemblyName System.Drawing

$sourcePath = "assets\logo-horizontal.jpeg"
$destPath = "assets\logo-og.jpeg"

$targetWidth = 1200
$targetHeight = 630

$img = [System.Drawing.Image]::FromFile($sourcePath)
$bmp = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)

$ratioX = $targetWidth / $img.Width
$ratioY = $targetHeight / $img.Height
$ratio = [Math]::Min($ratioX, $ratioY)
$scale = $ratio * 0.8

$newWidth = [int]($img.Width * $scale)
$newHeight = [int]($img.Height * $scale)

$posX = [int](($targetWidth - $newWidth) / 2)
$posY = [int](($targetHeight - $newHeight) / 2)

$g.DrawImage($img, $posX, $posY, $newWidth, $newHeight)

$bmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

$g.Dispose()
$bmp.Dispose()
$img.Dispose()

Write-Output "Image generated successfully."
