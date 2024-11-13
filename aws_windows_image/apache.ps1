# Ensure you run PowerShell as an Administrator

# Install Chocolatey if not already installed
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Apache HTTP Server
choco install apache-httpd -y --params '"/installLocation:C:\Apache24 /port:8080"'

# Verify installation
#& "C:\Apache24\bin\httpd.exe" -v