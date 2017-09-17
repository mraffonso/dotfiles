#!/bin/sh

APP_NAME=VLC\ Launcher.app
BUILD_PATH=$(mktemp -d /tmp/VLCLNCHR.XXXXXXXXX)
SCRIPT_PATH=../scripts/VLC\ Launcher.applescript
USER_APPLICATIONS_PATH=$HOME/Applications

install_launcher()
{
  echo "Installing the launcher"
  echo mv -f "$BUILD_PATH/$APP_NAME" "$USER_APPLICATIONS_PATH"
}

echo "Compiling script"

osacompile -o "$BUILD_PATH/$APP_NAME" "$SCRIPT_PATH"
status=$?

if [ $status != 0 ]; then
   echo "Failed with code $?"
else
  echo "Compile completed"
  install_launcher
fi

echo "Done"
echo
