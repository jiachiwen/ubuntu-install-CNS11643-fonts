#!/bin/bash

# ######################################################################################################## #
# Author: hms5232
# Source code and manual on https://github.com/hms5232/ubuntu-install-CNS11643-fonts
# Contact, report bugs or ask questions: https://github.com/hms5232/ubuntu-install-CNS11643-fonts/issues
# ######################################################################################################## #

# if ~/.fonts dir not exist, then create it.
if [ ! -d "$HOME/.fonts" ] ; then
    mkdir $HOME/.fonts
    echo -e "create ~/.fonts/ \n"
fi

# when Open_Data.zip exists, users must check out they wanna to download again or not
if [ -f "Open_Data.zip" ] ; then
	read -p "Open_Data.zip already exists. Do you want to delete it and download again? [y/n]" re_download
	case $re_download in
		[yY][eE][sS]|[yY])
			echo -e "remove Open_Data.zip...\n"
			rm Open_Data.zip
			echo -e "\n"
			# download CNS11643中文標準交換碼全字庫（簡稱全字庫）
			# 正楷體、正宋體
			# TW-Kai, TW-Sung
			wget http://www.cns11643.gov.tw/AIDB/Open_Data.zip
			;;
		*)
			read -p "Use the existing Open_Data.zip? [y/n]" re_use
			case $re_use in
				[yY][eE][sS]|[yY])
					echo -e "Skip download."
					echo -e "\n"
					;;
				*)
					echo -e "\n"
					echo -e "============== Exit shell script! =============="
					exit
					;;
			esac
	esac
fi

# let's hash it~
# but we don't have offical sha1sum file Orz
hash=$(sha1sum Open_Data.zip | cut -d ' ' -f 1)
echo -e "\n The SHA1 value of downloaded file is \n"
echo -e "\t>>>>> $hash <<<<<\n"

# unzip
unzip Open_Data.zip

# check zip file download and upzip succefully
if [ ! -d "Open_Data/" ] ; then
	echo -e "\n\n"
	echo -e "\a========= The font file went wrong! Please try again later. =========\n"
	exit 1
fi

# copy fonts to ~/.fonts
cp -i Open_Data/Fonts/*.ttf $HOME/.fonts

# refresh fonts cache
sudo fc-cache -fv

# remove zip and unzip dir
rm Open_Data.zip
rm -r Open_Data/

# finally
echo -e "\n\n"
echo -e "============== This is the end of script. ============== \n"
