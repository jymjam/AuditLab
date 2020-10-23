function Scan-ort($ip)
{$computer=$ip
 $port=Read-Host "enter ports eg: 22,25,80"
 $port.split(',') | Foreach-Object -Process {If (($a=Test-NetConnection $computer -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) {Write-Host $a.Computername $a.RemotePort -ForegroundColor Green -Separator " ==> "} else {Write-Host $a.Computername $a.RemotePort -Separator " ==> " -ForegroundColor Red}}
 }

function ne-port($ip){
    $enterPorts = Read-Host "enter port range. eg: 21-80"
    $p1, $p2 = $enterPorts.Split('-')
    $ports = $p1..$p2
    foreach ($port in $ports){
       if(($a=Test-NetConnection $ip -Port $port -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true){
            Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Green
       }else {
            Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Red
       }
    }
}
###################################3
function new-scan-port($ip){
    $port_format = Read-Host '1 > enter port range eg: 21-80 || 2> enter individual ports eg: 22,53,80,443'

    if($port_format -eq '1'){

        $enterPorts = Read-Host "enter port range. eg: 21-80"
        $p1, $p2 = $enterPorts.Split('-')
        $ports = $p1..$p2

        foreach ($port in $ports){
           if(($a=Test-NetConnection $ip -Port $port -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true){
                Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Green
           }else {
                Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Red
           }
        }
    }else{
        $port=Read-Host "enter ports eg: 22,25,80"
        $port.split(',') | Foreach-Object -Process {If (($a=Test-NetConnection $ip -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) {Write-Host $a.Computername $a.RemotePort -ForegroundColor Green -Separator " ==> "} else {Write-Host $a.Computername $a.RemotePort -Separator " ==> " -ForegroundColor Red}}
    }

    
}

function main(){
    $format = Read-Host "enter 1 > IP address range (eg: 10.10.10.0-10.10.10.255) || 2 > IP address"
    if($format -eq '1'){
        $ip_range = Read-Host 'Enter IP range'
    }elseif ($format -eq '2'){
        $ip = Read-Host 'Enter an IP add'
        new-scan-port($ip)
    }else{
        Write-Host 'invalid choice'
    }

}
main
