$files = Get-ChildItem -Filter *.html

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    # Remove versioning from style.css and script.js to allow local testing
    $content = $content -replace 'href="style.css\?v=\d+"', 'href="style.css"'
    $content = $content -replace 'src="script.js\?v=\d+"', 'src="script.js"'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
