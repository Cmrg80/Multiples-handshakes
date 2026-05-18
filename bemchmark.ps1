$rtt = 17
$openssl = "C:\PeneDeBurro\OpenSSL-Win64\bin\openssl.exe"

Write-Host "Running TLS 1.3 benchmark..."
$t13 = & $openssl s_time -connect localhost:4433 -new -time 30 -tls1_3 -ciphersuites TLS_AES_128_GCM_SHA256 2>&1

Write-Host "Running TLS 1.2 benchmark..."
$t12 = & $openssl s_time -connect localhost:4433 -new -time 30 -tls1_2 -cipher ECDHE-RSA-AES128-GCM-SHA256 2>&1

function GetRate($txt){
    if($txt -match "([0-9]+\.[0-9]+) connections/user sec"){
        return [double]$matches[1]
    }
}

$r13 = GetRate($t13)
$r12 = GetRate($t12)

$cpu13 = 1000 / $r13
$cpu12 = 1000 / $r12

$total13 = $cpu13 + $rtt
$total12 = $cpu12 + (2 * $rtt)

$out = @()
$out += "TLS,connections_per_sec,CPU_ms,Total_ms"
$out += "TLS1.3,$r13,$cpu13,$total13"
$out += "TLS1.2,$r12,$cpu12,$total12"

$out | Set-Content "../benchmarks/results/benchmark_results.csv"

Write-Host "Benchmark completed."
