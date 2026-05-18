$content = Get-Content -Path "style_live.css" -Raw -Encoding UTF8

$content = $content -replace "\.details-content ul li::before \{[\s\S]*?\}", @'
.details-content ul li::before {
    content: '\2713';
    position: absolute;
    left: 0;
    color: var(--color-secondary);
    font-weight: bold;
}
'@

[System.IO.File]::WriteAllText("style.css", $content, [System.Text.Encoding]::UTF8)
