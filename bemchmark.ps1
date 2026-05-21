After benchmarks were run
You may create a new carpet named "data" in your route
Example:
C:\Proyecto\data
Then verify that data is inside of 
PS C:\Users\ASUS TUF DASH F15> cd C:\Proyecto
PS C:\Proyecto> dir


    Directorio: C:\Proyecto


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----         5/20/2026   9:14 PM                data
d-----         4/20/2026   6:44 AM                OpenSSL-Win64
-a----         4/20/2026   6:41 AM        5739899 Win64OpenSSL_Light-4_0_0.exe

After that, set benchmark_results.csv inside data 
PS C:\Proyecto> $out | Set-Content "data\benchmark_results.csv"
PS C:\Proyecto> type data\benchmark_results.csv.

Then, run the benchmark
$rtt = 17
$openssl = "C:\Proyecto\OpenSSL-Win64\bin\openssl.exe"

Write-Host "Running TLS 1.3 benchmark..."
$t13 = & $openssl s_time -connect localhost:4433 -new -time 30 -tls1_3 -ciphersuites TLS_AES_128_GCM_SHA256 2>&1

Write-Host "Running TLS 1.2 benchmark..."
$t12 = & $openssl s_time -connect localhost:4433 -new -time 30 -tls1_2 -cipher ECDHE-RSA-AES128-GCM-SHA256 2>&1

function GetRate($txt){
    $joined = $txt -join "`n"
    if($joined -match "([0-9]+\.[0-9]+)\s+connections/user sec"){
        return [double]$matches[1]
    }
    return 0
}

$r13 = GetRate($t13)
$r12 = GetRate($t12)

$out = @()
$out += "TLS,connections_per_sec,Estimated_Total_ms"
$out += "TLS1.3,$r13,17"
$out += "TLS1.2,$r12,34"

$out | Set-Content "data\benchmark_results.csv"

Write-Host "Benchmark completed."
