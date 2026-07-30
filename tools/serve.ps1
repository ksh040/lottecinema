param(
  [int]$Port = $(if ($env:PORT) { [int]$env:PORT } else { 5500 }),
  [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$logPath = Join-Path $PSScriptRoot "serve.log"
"--- start $(Get-Date -Format o) port=$Port root=$Root ---" | Out-File -FilePath $logPath -Encoding utf8

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
try {
  $listener.Start()
} catch {
  "FATAL start error: $($_.Exception.Message)" | Out-File -FilePath $logPath -Append -Encoding utf8
  throw
}
"Serving $Root at http://localhost:$Port/" | Out-File -FilePath $logPath -Append -Encoding utf8

$mimeTypes = @{
  ".html" = "text/html; charset=utf-8"
  ".css"  = "text/css; charset=utf-8"
  ".js"   = "application/javascript; charset=utf-8"
  ".json" = "application/json; charset=utf-8"
  ".png"  = "image/png"
  ".jpg"  = "image/jpeg"
  ".jpeg" = "image/jpeg"
  ".gif"  = "image/gif"
  ".svg"  = "image/svg+xml"
  ".woff" = "font/woff"
  ".woff2"= "font/woff2"
  ".ttf"  = "font/ttf"
  ".otf"  = "font/otf"
  ".ico"  = "image/x-icon"
}

while ($listener.IsListening) {
  try {
    $context = $listener.GetContext()
  } catch {
    "GetContext error: $($_.Exception.Message)" | Out-File -FilePath $logPath -Append -Encoding utf8
    break
  }

  try {
    $request = $context.Request
    $response = $context.Response

    $urlPath = [System.Uri]::UnescapeDataString($request.Url.AbsolutePath)
    if ($urlPath -eq "/") { $urlPath = "/index.html" }

    $filePath = Join-Path $Root ($urlPath.TrimStart("/"))
    $fullRoot = (Resolve-Path $Root).Path

    if ((Test-Path $filePath -PathType Leaf)) {
      $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
      $contentType = $mimeTypes[$ext]
      if (-not $contentType) { $contentType = "application/octet-stream" }
      $bytes = [System.IO.File]::ReadAllBytes($filePath)
      $response.ContentType = $contentType
      $response.ContentLength64 = $bytes.Length
      $response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $response.StatusCode = 404
      $notFound = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $urlPath")
      $response.ContentLength64 = $notFound.Length
      $response.OutputStream.Write($notFound, 0, $notFound.Length)
      "404 $urlPath" | Out-File -FilePath $logPath -Append -Encoding utf8
    }
    $response.OutputStream.Close()
  } catch {
    ("REQUEST ERROR: " + $_.Exception.Message) | Out-File -FilePath $logPath -Append -Encoding utf8
    try { $context.Response.OutputStream.Close() } catch {}
  }
}

"--- listener stopped ---" | Out-File -FilePath $logPath -Append -Encoding utf8
