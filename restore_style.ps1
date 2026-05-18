# Read the downloaded file
$content = Get-Content -Path "style_live.css" -Raw -Encoding UTF8

# The live file has content: 'o"'; which is âœ“ but might be read as weird characters.
# To be safe, we use regex to replace the content of that specific block
$content = $content -replace "content: '.*';", "content: '\2713';"

# Let's also ensure .site-notice-bar is present (it should be since it's the live file if they pushed it)
# Write it back to the main style.css
[System.IO.File]::WriteAllText("style.css", $content, [System.Text.Encoding]::UTF8)
