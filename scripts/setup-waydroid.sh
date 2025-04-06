#!/bin/sh

sudo waydroid init -s GAPPS -f

sudo systemctl start waydroid-container
sudo systemctl enable waydroid-container
