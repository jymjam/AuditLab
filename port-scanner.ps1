function Scan-Port
{$computer= Read-Host "enter IP"
 $port=Read-Host "enter ports"
 $port.split(',') | Foreach-Object -Process {If (($a=Test-NetConnection $computer -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) {Write-Host $a.Computername $a.RemotePort -ForegroundColor Green -Separator " ==> "} else {Write-Host $a.Computername $a.RemotePort -Separator " ==> " -ForegroundColor Red}}
 }


 function new-scan-port{
    $enterPorts = Read-Host "enter ports in format 21-80"
    $p1, $p2 = $enterPorts.Split('-')
    $ports = $p1..$p2
    foreach ($port in $ports){
       if(($a=Test-NetConnection '192.168.1.109' -Port $port -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true){
            Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Green
       }else {
            Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Red
       }
    }
}
new-scan-port
