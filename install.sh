#!/bin/bash

# Website:       https://github.com/antonionarcilio
# Author:        Antonio Narcilio
# Maintenance:   Antonio Narcilio
# Version:       2.0
# Last release   June 09, 2021
#
# --------------------------------------------------------------------------- #
# 💡  WHAT DOES THIS SCRIPT DO ?
#     This script checks and "installs the necessary dependencies" for the 
#     thumbnail generation script to work correctly
# 
# --------------------------------------------------------------------------- #
# 💡  HOW TO USE IT? ?
#
# 1.  Give the script `install.sh` execute permission
# 1.1 chmod +x ./install.sh 
# 1.2 run in terminal: ./install.sh
#
#     OR
#
# 2.  Right-click the mouse on the script `install.sh`, select 
#     properties > permissions and check the `is executable` box
# 2.1 Double click on the file and select run
#
# Just run the install.sh script and it will do the rest ...
#
# --------------------------------------------------------------------------- #
# 💡  FOR MORE INFORMATION, READ README.MD
#
# config shellcheck
# shellcheck disable=SC2086

# - - - - - - - - - - - - - -  GLOBAL VARIABLES  - - - - - - - - - - - - - -  #

# YOU CAN CHANGE
KD_ICON="an-effects";
KD_ICON_WARNING="an-alert";
# DON'T CHANGE
REPEAT=1;
BINARY_DIR=/bin;
USER_NAME=$(whoami);
SCRIPT_FILE="generate_thumbnails";
# SCRIPTS_DIR="scripts-contact_sheet";
ICON_DIR="icons";
EMOJI_DIR="emojis";
ICONS_SAVE_DIR="/usr/share/pixmaps";
CONTEXT_MENU_FILE="generate-thumbnails.desktop";
# DOLPHIN_CONTEXT_MENU_DIR=/usr/share/kservices5/ServiceMenus;
DOLPHIN_CONTEXT_MENU_DIR=~/.local/share/kservices5/ServiceMenus/;
FONT_DIR="fonts";
FONT_SAVE_DIR=/usr/local/share/fonts/r;

LOG=/tmp/log_an_script_install.txt;

# Getting display size
AXIS_X=$(xrandr -q | grep Screen | awk '{ print $8 }');
AXIS_Y=$(xrandr -q | grep Screen | awk '{ print $10 }' | awk -F"," '{ print $1 }');


# - - - - - - - - - - - - - - - - - KDIALOG - - - - - - - - - - - - - - - - - #

# EXPECTED 2 ARGUMENTS → "TITLE" "MESSAGE"
function kDialogProgressBar() {
		dbusRef=$(kdialog --title "$1" --icon $KD_ICON --progressbar "<h4>$2</h4>" 4); 
		qdbus $dbusRef Set "" value 1  > /dev/null;
		sleep 1;
		qdbus $dbusRef Set "" value 2 > /dev/null;
		sleep 1;
		qdbus $dbusRef Set "" value 3 > /dev/null;
		sleep 1;
		qdbus $dbusRef Set "" value 4 > /dev/null;

		qdbus $dbusRef close > /dev/null;
}
# EXPECTED 2 ARGUMENTS → "TITLE" "MESSAGE"
function kDialogWarningYesNoCancel() {
	kdialog --title "$1" --icon $KD_ICON  --yesnocancel "<h4>$2</h4>";
  KD_YESNO_STATUS=$?;
}
# EXPECTED 1 ARGUMENT → "TITLE"
function kDialogPopup() {
	kdialog --icon $KD_ICON --title "$1" --passivepopup "$2" "$3";
}
# Expect to pass 2 parameters "TITLE" "MESSAGE"
function kDialogPopUpWarning() {
  kdialog \
    --title "$1" \
    --icon $KD_ICON_WARNING \
    --passivepopup "<h5>$2</h5>" 10;
}
# EXPECTED 2 ARGUMENTS → "TITLE" "MESSAGE"
function kDialogPassword() {
	kdialog --title	"$1" --password "$2";
  KD_PASSWORD_STATUS=$?;
}
# EXPECTED 1 ARGUMENTS → "FILE.txt"
function kDialogTextBox() {
  kdialog \
    --title "⚠ Errors found ⚠" \
    --textbox "$1" \
    --geometry 500x300+"${AXIS_X}"+"${AXIS_Y}";
}


# - - - - - - - - - - - - - - - -  FUNCTIONS  - - - - - - - - - - - - - - - - #

function main() {

	while [[ $REPEAT = 1 ]]; do
		REPEAT=0;
		PASSWORD=$(kDialogPassword "Install generate thumbnails 🎞" "<h3>Enter your password 🔐</h3>");
    # EXPECTED 2 ARGUMENTS → "TITLE" "MESSAGE"

    # continue ?
		if [[ "$KD_PASSWORD_STATUS" -eq 0 ]];	then
      echo  "$PASSWORD" | sudo -S su;
      is_sudo=$?;
      
      # the user is not superuser ?
      if [[ $is_sudo -gt 0 ]]; then 
        kDialogWarningYesNoCancel "Error ⚠" "Incorrect Password❗<br>Do you wish to continue❓";
        # EXPECTED 2 ARGUMENTS - "TITLE" "MESSAGE"
        # is repeat ?
        if [[ $KD_YESNO_STATUS = 0 ]]; then
          REPEAT=1;
        # is not repeat ?
        elif [[ $KD_YESNO_STATUS = 1 ]]; then
          kDialogPopup "Canceled !" "Files 🗃 were not copied 📤" 5;
          # EXPECTED 1 ARGUMENTS - "MESSAGE"
          exit 0 > /dev/null 2>&1;
        # Is it to cancel ?
        else
          kDialogProgressBar "Please wait ... 🛑" "Canceling installation process ...";
          # EXPECTED 2 ARGUMENTS - "TITLE" "MESSAGE"
          exit 0 > /dev/null 2>&1;
        fi;
        
      # User is root ?
      else
        # COPY DOLPHIN CONTEXT MENU - - - - - - - - - - - - - - - - - - - - -  #
        sudo -S cp $CONTEXT_MENU_FILE "$DOLPHIN_CONTEXT_MENU_DIR" 2>> $LOG;
        if [[ $? -eq 1 ]]; then  
          status=1
        else
          sudo chown "$USER_NAME":"$USER_NAME" "${DOLPHIN_CONTEXT_MENU_DIR}/${CONTEXT_MENU_FILE}" && \
          chmod +x ${DOLPHIN_CONTEXT_MENU_DIR}/"${CONTEXT_MENU_FILE}";
        fi;  
        # COPY ICONS - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
        sudo -S cp "${ICON_DIR}"/*.svg "$ICONS_SAVE_DIR" 2>> $LOG;
        if [[ $? -eq 1 ]]; then  
          status=1
        else
          sudo chown "$USER_NAME":"$USER_NAME" "${ICONS_SAVE_DIR}/"an-*.svg;
        fi;       
        # COPY EMOJIS  - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
        sudo -S cp -r "$EMOJI_DIR" "$ICONS_SAVE_DIR" 2>> $LOG;
        if [[ $? -eq 1 ]]; then  
          status=1
        else
          sudo chown "$USER_NAME":"$USER_NAME" "${ICONS_SAVE_DIR}/${EMOJI_DIR}" && \
          sudo chown "$USER_NAME":"$USER_NAME" "${ICONS_SAVE_DIR}/${EMOJI_DIR}"/*;
        fi;
        # COPY FONTS - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
        sudo -S cp "${FONT_DIR}"/*.ttf "$FONT_SAVE_DIR" 2>> $LOG;
        if [[ $? -eq 1 ]]; then  
          status=1
        else
          sudo fc-cache -f;
        fi;  
        # COPY SCRIPTS  - - - - - - - - - - - - - - - - - - - - - - - - - - -  #
        sudo -S cp -r "$SCRIPT_FILE" "$BINARY_DIR" 2>> $LOG;
        if [[ $? -eq 1 ]]; then  
          status=1
        else
          sudo chown "$USER_NAME":"$USER_NAME" "${BINARY_DIR}/${SCRIPT_FILE}" && \
          sudo chmod +x "${BINARY_DIR}/${SCRIPT_FILE}"
        fi;

        # Any problems were found?
        if [[ "$status" == 1 ]]; then
          kDialogPopUpWarning "Something unexpected happened 😢" "<b>The installation process was not successful, check the log 📄</b>";
          # Expected 2 arguments "TITLE" "MESSAGE"
          kDialogTextBox "$LOG";
          # Expected 1 arguments "FILE.txt"
          echo "" > "$LOG";
          # reset log
        # no problems were found?
        else
          kDialogPopup "Success ✅" "<b>Generate Thumbnails 🎞 installed 😎</b>" 5;
          # Expected 2 arguments "TITLE" "MESSAGE"
          echo "Generate Thumbnails 🎞  installed 😎";
        fi;
      fi;
		# cancel ?
		else
			kDialogProgressBar "Please wait ... 🛑" "Canceling installation process ...";
			# Expected 2 arguments	
			exit 0 > /dev/null 2>&1;
		fi;

	done;
}


function verifyDependencies() {
  # imagemagick is isntall ?
  function imagemagickVerify() {
    convert --version > /dev/null 2>&1;
    is_exist_imagemagick=$?;

    if [[ $is_exist_imagemagick -ne 0 ]]; then
      msg=("ImageMagic is required !" "Access the site: <a href='https://imagemagick.org/script/download.php'>ImageMagick</a> for more,<br>or run the command<br><b>sudo \"apt/pacman -S\" imagemagick</b>");
      kDialogPopUpWarning "${msg[0]}" "${msg[1]}";
      # |-> Expect to pass 2 parameters "TITLE" "MESSAGE"
      echo -e "\e[1;33m${msg[0]}\e[0m";
    fi;
  }  
  # ffmpeg is isntall ?
  function ffmpegVerify() {
    ffmpeg -version > /dev/null 2>&1;
    is_exist_ffmpeg=$?;

    if [[ $is_exist_ffmpeg -ne 0 ]]; then
      msg=("FFMPEG is required !" "Access the site: <a href='https://www.ffmpeg.org'>ffmpeg</a> for more,<br>or run the command<br><b>sudo \"apt/pacman -S\" ffmpeg</b>");
      kDialogPopUpWarning "${msg[0]}" "${msg[1]}";
      # |-> Expect to pass 2 parameters "TITLE" "MESSAGE"
      echo -e "\e[1;33m${msg[0]}\e[0m";
    fi;
  }
  # kdialog is isntall ?
  function kdialogVerify() {
    kdialog --version  > /dev/null 2>&1;
    is_exist_kdialog=$?;

    if [[ $is_exist_kdialog -eq 0 ]]; then
      imagemagickVerify;
      ffmpegVerify;
    else
      echo -e "Kdialog is required!\nRun the command:\n\e[1;33msudo \"apt/pacman -S\" ffmpeg\e[0m";
      exit 0 > /dev/null 2>&1;
    fi;
  }

  kdialogVerify;

  if [[ $is_exist_kdialog -eq 0 && $is_exist_imagemagick -eq 0 && $is_exist_ffmpeg -eq 0 ]]; then
    main;
  else
    exit 0 > /dev/null 2>&1;
  fi
}


# - - - - - - - - - - - - - - - - EXECUTION - - - - - -  - - - - - -  - - - - #

verifyDependencies;
