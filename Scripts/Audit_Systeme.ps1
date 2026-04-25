# script d'Audit Santé Système Rapide
# Auteur : Tsiory
# Date ; 25/04/2026

Clear-Host
Write-Host "--- RAPPORT D'AUDIT SYSTÈME ---" -ForegroundColor Cyan

# 1. Vérification de l'espace disque (Disque C:)

$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$freespaceGB = [Math]::Round($disk.Freespace / 1GB, 2)
$totalSpaceGB = [Math]::Round($disk.Size / 1GB, 2)
Write-Host "Espace Disque C:
$freeSpaceGB Go libres sur
$totalSpaceGB Go"

# 2. Vérification de la RAM utilisée

$os = Get-WmiObject Win32_OperatingSystem
$freeRAM = [Math]::Round($os.FreePhysicalMemory / 1MB, 2)
$totalRAM = [Math]::Round($os.TotalVisibleMemorySize / 1MB,2)
$usedRAM = $totalRAM - $freeRAM
Write-Host "Utilisation RAM:
$usedRAM Mo utilisés sur $totalRAM Mo"

# 3. Top 3 des processus les plus gourmands

Write-Host "`nTop 3 des processus (consommation RAM):" -ForegroundColor Yellow
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 3 Name,
@{Name="RAM(Mo)";Expression=
{[Math]::Round($_.WorkingSet64 / 1MB, 2)}} | Format-Table 

# 4. Vérification de l'état de Windows Update

$updateService = Get-Service -Name wuauserv
Write-Host "Service Windows update: " -NoNewline
if ($updateService.Status -eq 'Running') {
  Write-Host "ACTIF" 
  -ForegroundColor Green
} else {
  Write-Host "ARRETÉ" -ForegroundColor Red
}

Write-Host "`n--- Fin du rapport ---" -ForegroundColor Cyan


    
  


  
