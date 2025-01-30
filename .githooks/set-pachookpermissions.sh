#!/bin/sh
#
# Ensure hook files have appropriate permissions set before commit; ensures
# that the files -- if the repository is cloned directly to /etc/pacman.d/hooks
# -- will have the correct permissions without the user needing to modify them
# therafter.

# ANSI escape codes for bold text
BOLD_ON='\033[1m'
BOLD_OFF='\033[0m'

echo -e "${BOLD_ON}Setting permissions (644) for pacman hooks...${BOLD_OFF}"
{
	chmod 644 *.hook -v
} || {
	# stdout to stderr
	exec 1>&2
	cat <<EOF
Error: Failed to set permissions (644) on pacman hook (*.hook) file(s).

This can be problematic if this repository is cloned directly to
/ect/pacman.d/hooks, as pacman hook files must not be executable, and should not
be writable by non-root users.
EOF
}
