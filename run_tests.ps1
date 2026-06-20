# Script para executar os testes Robot Framework
# Uso: .\run_tests.ps1
# Uso com tag: .\run_tests.ps1 -Tag smoke

param(
    [string]$Tag = "",
    [string]$Suite = "tests/"
)

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputDir = "results\$timestamp"

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

if ($Tag -ne "") {
    robot --include $Tag --outputdir $outputDir $Suite
} else {
    robot --outputdir $outputDir $Suite
}

Write-Host ""
Write-Host "Resultados em: $outputDir"
