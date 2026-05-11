#!/bin/bash
# You are NOT allowed to change the files' names!
domainNames="domainNames.txt"
domainNames2="domainNames2.txt"
IPAddressesSame="IPAddressesSame.txt"
IPAddressesDifferent="IPAddressesDifferent.txt"
adblockRules="adblockRules"

function adBlock() {
    if [ "$EUID" -ne 0 ];then
        printf "Please run as root.\n"
        exit 1
    fi
    if [ "$1" = "-domains"  ]; then
        # Find different and same domains in ‘domainNames.txt’ and ‘domainsNames2.txt’ files 
	   # and write them in “IPAddressesDifferent.txt and IPAddressesSame.txt" respectively
        # Write your code here...
        # ...
        if [ -f "$IPAddressesSame" ]; then
            rm "$IPAddressesSame"
        fi

        if [ -f "$IPAddressesDifferent" ]; then
            rm "$IPAddressesDifferent"
        fi

        comm -12 <(sort domainNames.txt) <(sort domainNames2.txt) | xargs dig +short >> IPAddressesSame.txt
        comm -13 <(sort domainNames.txt) <(sort domainNames2.txt) | xargs dig +short | grep -v '\.$' >> IPAddressesDifferent.txt
        comm -23 <(sort domainNames.txt) <(sort domainNames2.txt) | xargs dig +short | grep -v '\.$' >> IPAddressesDifferent.txt

        echo "File generation done!"
        true
            
    elif [ "$1" = "-ipssame"  ]; then
        # Configure the DROP adblock rule based on the IP addresses of $IPAddressesSame file.
        # Write your code here...
        # ...
        # ...
        for x in $(cat $IPAddressesSame)
        do
             iptables -A INPUT -s $x -j DROP
             iptables -A FORWARD -s $x -j DROP
             iptables -A OUTPUT -d $x -j DROP
        done

        echo "Adblock DROP rule configured based on the IP addresses of IPAddressesSame.txt!"

        true
    elif [ "$1" = "-ipsdiff"  ]; then
        # Configure the REJECT adblock rule based on the IP addresses of $IPAddressesDifferent file.
        # Write your code here...
        # ...
        # ...
        for x in $(cat $IPAddressesDifferent)
        do
             iptables -A INPUT -s $x -j REJECT
             iptables -A FORWARD -s $x -j REJECT
             iptables -A OUTPUT -d $x -j REJECT
        done

        echo "Adblock REJECT rule configured based on the IP addresses of IPAddressesDifferent.txt!"
        true
        
    elif [ "$1" = "-save"  ]; then
        # Save rules to $adblockRules file.
        # Write your code here...
        # ...
        # ...
        iptables-save > $adblockRules
        echo "Adblock rules saved on adblockRules!"
        true
        
    elif [ "$1" = "-load"  ]; then
        # Load rules from $adblockRules file.
        # Write your code here...
        # ...
        # ...
        iptables-restore < $adblockRules
        echo "Adblock rules loaded from adblockRules!"
        true

        
    elif [ "$1" = "-reset"  ]; then
        # Reset rules to default settings (i.e. accept all).
        # Write your code here...
        # ...   
        # ...
        iptables -P INPUT ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -P FORWARD ACCEPT

        iptables -F

        echo "Adblock rules have been reset to default!"
        true

        
    elif [ "$1" = "-list"  ]; then
        # List current rules.
        # Write your code here...
        # ...
        # ...
        iptables -S
        true
        
    elif [ "$1" = "-help"  ]; then
        printf "This script is responsible for creating a simple adblock mechanism. It rejects connections from specific domain names or IP addresses using iptables.\n\n"
        printf "Usage: $0  [OPTION]\n\n"
        printf "Options:\n\n"
        printf "  -domains\t  Configure adblock rules based on the domain names of '$domainNames' file.\n"
        printf "  -ipssame\t\t  Configure the DROP adblock rule based on the IP addresses of $IPAddressesSame file.\n"
	printf "  -ipsdiff\t\t  Configure the DROP adblock rule based on the IP addresses of $IPAddressesDifferent file.\n"
        printf "  -save\t\t  Save rules to '$adblockRules' file.\n"
        printf "  -load\t\t  Load rules from '$adblockRules' file.\n"
        printf "  -list\t\t  List current rules.\n"
        printf "  -reset\t  Reset rules to default settings (i.e. accept all).\n"
        printf "  -help\t\t  Display this help and exit.\n"
        exit 0
    else
        printf "Wrong argument. Exiting...\n"
        exit 1
    fi
}

adBlock $1
exit 0
