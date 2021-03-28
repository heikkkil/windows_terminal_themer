#!/bin/bash
# Author: Heikki Kilpeläinen
# Lisence: MIT (see repository)

# Settings:

# Windows user who is using Windows Terminal
WT_WIN_USER=""
# Windows Terminal's AppData directory
WT_APPDATA_PACKAGE="Microsoft.WindowsTerminal_8wekyb3d8bbwe"
# Verbosity
WT_THEME_VERBOSE=0
# Dryrun without conducting changes to fs (for testing)
WT_THEME_DRYRUN=0


# Functions:

theme() {
	# Sanity check
	WT_SANITY_FAIL=0

	if [ ! $# -eq 1 ]; then
		echo "Usage: theme light | dark | restore"
		WT_SANITY_FAIL=1
	fi
	if [ -z $WT_WIN_USER ]; then
		echo "Error: Provide windows user for script settings"
		WT_SANITY_FAIL=1
	fi
	if [ -z $WT_APPDATA_PACKAGE ]; then
		echo "Error: Provide appdata package path for script settings"
		WT_SANITY_FAIL=1
	fi
	if [ ! $WT_SANITY_FAIL -eq 0 ]; then
		return 0
	fi

	# Windows Terminal settings.json path
	WT_SETTINGS_PATH="/mnt/c/Users/$WT_WIN_USER/AppData/Local/Packages/$WT_APPDATA_PACKAGE/LocalState/"
	# Predefined settings.json files
	WT_SETTINGS_FILE="settings.json"
	WT_THEME_RESTORE="settings.bak"
	WT_THEME_LIGHT="settings_debian_light"
	WT_THEME_DARK="settings_debian_dark"

	if [ ! $WT_THEME_DRYRUN -eq 0 ]; then
		echo "Dryrun:"
		WT_THEME_VERBOSE=1
	fi

	# Test argument
	case $1 in

	light | l* | L*)
		if [ $WT_THEME_DRYRUN -eq 0 ]; then
			\cp $WT_SETTINGS_PATH$WT_THEME_LIGHT $WT_SETTINGS_PATH$WT_SETTINGS_FILE
		fi
		if [ $WT_THEME_VERBOSE -eq 1 ]; then
			echo "Theme set to light"
		fi
		;;
	dark | d* | D* )
		if [ $WT_THEME_DRYRUN -eq 0 ]; then
			\cp $WT_SETTINGS_PATH$WT_THEME_DARK $WT_SETTINGS_PATH$WT_SETTINGS_FILE
		fi
		if [ $WT_THEME_VERBOSE -eq 1 ]; then
			echo "Theme set to dark"
		fi
		;;
	reset | r* | R*)
		if [ $WT_THEME_DRYRUN -eq 0 ]; then
			\cp $WT_SETTINGS_PATH$WT_THEME_RESTORE $WT_SETTINGS_PATH$WT_SETTINGS_FILE
		fi
		if [ $WT_THEME_VERBOSE -eq 1 ]; then
			echo "Theme reset"
		fi
		;;
	*)
		echo "Bad argument '$1': nothing done"
		return 0
		;;
	esac
}
