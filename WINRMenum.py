# Purpose: This script checks if the given WINRM credentials are valid or not, for enumeration purposes. 
# Usage: WINRMenum.py [IP] [Username] [Password]

from base64 import b64encode
from sys import argv
import http.client

if len(argv) != 4:
	print('Usage: {} <ip> <username> <password>'.format(argv[0]))
	print('The script checks if the given WINRM credentials are valid, works for basic winrm authentication')
	exit(1)

# The headers needed for WinRM requests

headers = {
  'Content-Type': 'application/soap+xml;charset=UTF-8',
  'Authorization': 'Basic {}'.format(b64encode(argv[2].encode()+b':'+argv[3].encode()).decode()),
}

# SOAP envelope
envelope = b'<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope" xmlns:wsmid="http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd"><s:Header/><s:Body><wsmid:Identify/></s:Body></s:Envelope>'

# Open a connection to port 5985 (winrm)
conn = http.client.HTTPConnection('{}:5985'.format(argv[1]))
# Don't add an Accept-Encoding header
conn.putrequest("POST", "/wsman", skip_accept_encoding=True)
# Set the Content-Length corrrectly
headers['Content-Length'] = len(envelope)
# Set each header
for header, value in headers.items():
	conn.putheader(header, value)
conn.endheaders()
# Send the request
conn.send(envelope)
# Get the response
response = conn.getresponse()
# Get the HTTP status code
status = response.status
conn.close()

# 200 OK
if status == 200:
	print('[+] Correct username and password given')
else:
	print('[-] Incorrect username or password given')
