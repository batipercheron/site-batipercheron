$content = Get-Content -Path "style_live.css" -Raw -Encoding UTF8

# Restore the original first
$content = $content -replace "content: '\\2713';", 'content: "";'

# Only replace the specific ul li::before block
$oldBlock = @"
.details-content ul li::before {
    content: 'o"';
"@

$newBlock = @"
.details-content ul li::before {
    content: '\2713';
"@

$content = $content.Replace($oldBlock, $newBlock)

# Write it back to the main style.css
[System.IO.File]::WriteAllText("style.css", $content, [System.Text.Encoding]::UTF8)
