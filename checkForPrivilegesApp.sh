#!/bin/zsh

###################################################\\* checkForPrivilegsApp.sh *//##########################################
# This script checks for the Privileges application and if installed promotes the user to Administrator when user clicks on Update Now button from Nudge
#
# Created by Howard Griffith - University of Texas at Austin - LAITS Senior Systems Manager
# Last Modified: 6/10/2022
####################################################################################################################

/bin/echo "Checking if Privileges app is installed..."
if [[ -d "/Applications/Privileges.app" ]]; then
    /bin/echo "Found Privileges.app on the machine in Applications..."
    privilegesCLIlocation="/Applications/Privileges.app/Contents/Resources/PrivilegesCLI"
    adminAccessEnabled="YES"
elif [[ -d "/Applications/Utilities/Privileges.app" ]]; then
    /bin/echo "Found Privileges.app on the machine in Applications/Utilities..."
    privilegesCLIlocation="/Applications/Utilities/Privileges.app/Contents/Resources/PrivilegesCLI"
    adminAccessEnabled="YES"
else
    /bin/echo "Privileges application not found on machine, exiting check..."
    exit 0
fi
           
#Get status of current user from Privileges CLI
userIsAdmin=$(($privilegesCLIlocation --status) 2>&1)

if [[ ${adminAccessEnabled} = "YES" ]] && [[ ${userIsAdmin} =~ standard ]]; then
    /bin/echo "Administrator access needed and user is not admin, elevating now..."
    $privilegesCLIlocation --add
else
    /bin/echo "Administrator access enabled already, proceeding..."
fi
