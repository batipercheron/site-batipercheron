$lines = Get-Content "style.css" -Encoding UTF8
# Take only the lines before the corruption starts
$goodLines = $lines[0..1277]

$cookieCss = @"

/* === Bannière de cookies === */
.cookie-banner {
    position: fixed;
    bottom: 20px;
    left: 20px;
    right: 20px;
    max-width: 800px;
    margin: 0 auto;
    background: var(--color-white);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    border-radius: 12px;
    z-index: 9999;
    padding: 20px;
    border-left: 5px solid var(--color-primary);
    font-family: var(--font-body);
}

.cookie-content {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.cookie-content p {
    font-size: 0.95rem;
    color: var(--color-text);
    margin: 0;
    line-height: 1.5;
}

.cookie-buttons {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
}

.cookie-buttons button {
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.2s ease;
    border: none;
}

.btn-cookie-accept {
    background: var(--color-primary);
    color: var(--color-white);
}

.btn-cookie-accept:hover {
    background: var(--color-secondary);
}

.btn-cookie-refuse {
    background: #f1f1f1;
    color: var(--color-text);
}

.btn-cookie-refuse:hover {
    background: #e1e1e1;
}

@media (min-width: 768px) {
    .cookie-content {
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
    }
    .cookie-content p {
        flex: 1;
    }
}
"@

$finalContent = ($goodLines -join "`r`n") + "`r`n" + $cookieCss
[System.IO.File]::WriteAllText("style.css", $finalContent, [System.Text.Encoding]::UTF8)
