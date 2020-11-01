# What is it?
AuditLab is a cutting edge run-of-the-mill collection of Homemade security auditing tools. 

## What's inside?
* #### Port-scanner : Powershell
    > Scan target ports
* #### Ping-sweeper : Python
    > Asset discovery w/ ICMP probing
* #### DNSenum : Powershell
    > DNS enumeration tool
* #### WINRMenum : Python
    > WINR enumeration tool
* #### OSenum : Shell
    > Host's OS check
## Run, how?

* __Port-scanner__
    * start powershell
    * call the script ./[script-name]
    * prepend [absolute-path-to-script] if necessary

* __Ping-sweeper__
    * Install required python modules
        > pip install -r requirements.txt
    * call the script
        > py [script-name]

* __DNSenum__
    * Store all targets in a .txt file
    * open powershell
        > [script-name] [.txt]
    * prepend absolute path if necessary

* __WINRMenum__
    * call script
        > py [script-name] [ip] [username] [password]

* __OSenum__
    * store all targets in .txt file
    * run the script in terminal
        >sh [script-name] [.txt]