Name: Georgios Kyriopoulos
AM: 2019030017

This script is a basic adblock. It can be executed using the following flags(sudo is required):
-domains: Is used to fill the IPAddressesSame.txt and IPAddressesDifferent.txt with the appropriate IPs.
-ipssame: Configures the DROP rule based on the IPs inside IPAddressesSame.txt.
-ipsdiff: Configures the REJECT rule based on the IPs inside IPAddressesDifferent.txt.
-save: Saves the rules in adblockRules.
-load: Loads the rules from adblockRules.
-reset: Reset the rules to default.
-list: List all the current rules.
-help: Help message.

This adblock since it's domain based can't obviously block all ads. It can only block ads from the domains 
inside domainNames.txt and domainNames2.txt. This means that when you visit a site only same of 
the ads will be blocked.

The -domains flags take about a min to run. 

