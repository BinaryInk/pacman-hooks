#!/bin/bash
#
# Ensure script files have appropriate permissions set before commit; ensures
# that the files -- if the repository is cloned directly to /etc/pacman.d/hooks
# -- will have the correct permissions without the user needing to modify them
# therafter.

REPOSITORYROOT=$(git rev-parse --show-toplevel)
EXITCODE=0

# ANSI escape codes for bold text
BOLD_ON='\033[1m'
BOLD_OFF='\033[0m'

echo -e "${BOLD_ON}Setting permissions (655) for script files...${BOLD_OFF}"
for file in ${REPOSITORYROOT}/*; do
	if [ -f "$file" ]; then
		case $file in
			*.sh |\
			*.ps1 |\
			*.fish |\
			*.csh |\
			*.py )
				echo $file
				chmod 655 "$file" -v || {
					echo "Failed to set permissions on script: '$file'" 1>&2; EXITCODE=1;
				}
				;;
		esac
	fi
done

if [ $EXITCODE -ne 0 ]; then
	# stdout to stderr
	exec 1>&2
	cat <<EOF
Error: Failed to set permissions (655) on one or more scripts.

This can be problematic if this repository is cloned directly to 
/etc/pacman.d/hooks, as scripts need to be marked as executable to run.
EOF
fi
