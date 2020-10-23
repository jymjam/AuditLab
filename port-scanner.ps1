function scan-single-ip($ip){
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


function scan-range($ip_range){
    $start_ip, $stop_ip = $ip_range.Split('-')
    $sub_start_ip1,$sub_start_ip2,$sub_start_ip3,$sub_start_ip4 = $start_ip.split('.')
    $sub_stop_ip1,$sub_stop_ip2,$sub_stop_ip3,$sub_stop_ip4 = $stop_ip.split('.')

    $ip_in_range = $sub_start_ip4..$sub_stop_ip4

    $port_format = Read-Host '1 > enter port range || 2 > enter ind. ports'
    if($port_format -eq '1'){
        $port_range = Read-Host "enter port range eg: 22-100"
        $p1, $p2 = $port_range.Split('-')
        $ports_to_scan = $p1..$p2
        foreach($ip in $ip_in_range){
            $ip_to_scan = $sub_start_ip1 + '.' + $sub_start_ip2 + '.' + $sub_start_ip3 + '.' + $ip
            foreach($port in $ports_to_scan){
                if(($a=Test-NetConnection $ip_to_scan -Port $port -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true){
                    Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Green
                }else {
                    Write-Host $a.Computername -Separator "==>" $a.RemotePort -ForegroundColor Red
                }
            }   
        }
    }else{
        $port_range = Read-Host "enter individual ports eg: 21,90,3100"
        foreach($ip in $ip_in_range){
            $ip_to_scan = $sub_start_ip1 + '.' + $sub_start_ip2 + '.' + $sub_start_ip3 + '.' + $ip
            $port_range.split(',') | Foreach-Object -Process {If (($a=Test-NetConnection $ip_to_scan -Port $_ -WarningAction SilentlyContinue).tcpTestSucceeded -eq $true) {Write-Host $a.Computername $a.RemotePort -ForegroundColor Green -Separator " ==> "} else {Write-Host $a.Computername $a.RemotePort -Separator " ==> " -ForegroundColor Red}}
        }
    }
}

function main(){
    $format = Read-Host "enter 1 > IP address range (eg: 10.10.10.0-10.10.10.255) || 2 > IP address"
    if($format -eq '1'){
        $ip_range = Read-Host 'Enter IP range'
        scan-range($ip_range)
    }elseif ($format -eq '2'){
        $ip = Read-Host 'Enter an IP add'
        scan-single-ip($ip)
    }else{
        Write-Host 'invalid choice'
    }

}

#calls main
main
