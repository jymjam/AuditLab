""" PING SWEEPER 
A lightweight script to probe with ICMP packets for asset discovery on a network.
"""
from platform import system as system_name  # Returns the system/OS name
import subprocess
import ipcalc

# ICMP probe
def ping(host):
    #Changes parameter based on OS
    param = '-n' if system_name().lower()=='windows' else '-c'

    output = subprocess.Popen(["ping", host, param, '1'], stdout=subprocess.PIPE).communicate()[0]
    
    # and then check the response...
    if b'unreachable' in output:
        print(f"Connection to {host} Unreachable!")
    elif b'try' in output:
        print(f'Connection to {host} Failed!')
    elif b'Request timed out' in output:
        print(f"Connection to {host} Timed Out!")
    else:
        print(f"Connection to {host} Passed!")

def ip_calc(IP, Format):
    Format = Format
    if Format == '1':
        start_ip, end_ip = IP.split('-')
        start_range = int(start_ip.split('.')[-1])
        end_range = int(end_ip.split('.')[-1])

        template_ip = start_ip.split('.')[0] + '.' + start_ip.split('.')[1] + '.' + start_ip.split('.')[2] + '.'
        for x in range(start_range, end_range + 1):
            current_ip = template_ip + str(x)
            ping(current_ip)
    elif Format == '2':
        for ips in ipcalc.Network(IP):
            ping(str(ips))
    else:
        print('wong format')

# running out in main
if __name__ == '__main__':
    try:
        Format = input(""" 
        1 -> 192.168.1.1-182.168.1.255 
        2 -> 192.168.1.1/24 """)
        domain_range = input("Specify the addresses in choosen format ")
        ip_calc(domain_range, Format)

        # start_ip, end_ip = domain_range.split('-')

        # start_range = int(start_ip.split('.')[-1])
        # end_range = int(end_ip.split('.')[-1])

        # template_ip = start_ip.split('.')[0] + '.' + start_ip.split('.')[1] + '.' + start_ip.split('.')[2] + '.'
        # for x in range(start_range, end_range + 1):
        #     current_ip = template_ip + str(x)
        #     ping(current_ip)
            
    except KeyboardInterrupt:
        print('user hard exited')
    except Exception as e:
        print(e)
