# Purpose: A DNS enumeration tool that takes a file containing a list of host names as input and returns the IP addresses of those hosts.
# Usage: powershell -ExecutionPolicy Bypass -File .\DNSenum.ps1 [hosts.txt]

Import-Module DnsClient


# The number of commandline arguments is 0, error

if ($args.Count -eq 0) {
  "Please specify a file containing hostnames to resolve";
  exit;
}

# For each line in the given file

Get-Content $args[0] | ForEach-Object {
    # Resolve the line as a hostname
    $resolution_result = Resolve-DnsName -Name $_ -Type A -DnsOnly -ErrorAction SilentlyContinue
    if ($resolution_result) {
      # Output the IP address if address resolution was successful
      "The IP address of $_ is " + $resolution_result.IPAddress
    }
    else {
      "Failed resolving $_"
    }
}
