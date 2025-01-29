#!/bin/sh

# This script updates the waybar custom module after pacman is finished
# installing/updating packages by sending a USRSIG to the running waybar
# application.

pkill -SIGRTMIN+8 waybar
