""" PING SWEEPER 
A lightweight script to probe with ICMP/TCP/UDP packets for asset discovery over a network.
"""
from platform   import system as system_name  # Returns the system/OS name
import socket
import subprocess

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

# TCP probe
def tcpPing(host):
    # Create a TCP/IP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    
    try:
        sock.connect((host, 80))

        # Send data
        message = b'Sending Random Data'
        sock.sendall(message)
        print(f'Connection to {host} Passed!')
        
    except socket.timeout:
        print(f"Connection to {host} Timed Out!")
    except ConnectionRefusedError:
        print(f"Connection to {host} Refused!")
    except:
        print(f'Connection to {host} Failed!')
        
    finally:
        sock.close()

# UDP probe
def udpPing(host):
    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.settimeout(1)
    message = b'Sending Random Data'

    try:
        # Send data
        sock.sendto(message, (host, 80))
        print(f'Connection to {host} Passed!')

    except socket.timeout:
        print(f"Connection to {host} Timed Out!")
    except ConnectionRefusedError:
        print(f"Connection to {host} Refused!")
    except:
        print(f'Connection to {host} Failed!')

    finally:
        sock.close()

# if name == main then the file is run directly (not imported)
if __name__ == '__main__':
    domain_range = input("Specify the domain range: ")
    ping_type = input("Specify ping type (udp/tcp/icmp): ")

    start_ip, end_ip = domain_range.split('-')

    start_range = int(start_ip.split('.')[-1])
    end_range = int(end_ip.split('.')[-1])

    template_ip = start_ip.split('.')[0] + '.' + start_ip.split('.')[1] + '.' + start_ip.split('.')[2] + '.'
    for x in range(start_range, end_range + 1):
        current_ip = template_ip + str(x)

        if(ping_type.lower() == 'icmp'):
            ping(current_ip)
        elif(ping_type.lower() == 'tcp'):
            tcpPing(current_ip)
        elif(ping_type.lower() == 'udp'):
            udpPing(current_ip)

