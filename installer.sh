#!/bin/bash
APPNAME="cloudcaveinstaller"
LOGPATH="/var/log/${APPNAME}.log"
WORKDIR="/usr/lib/${APPNAME}"
BINDIR="/usr/local/bin/"
MAHPID=$$
REQUIRED_PKGS="vim screen git build-essential qemu-system libvirt-daemon-system-sysv libvirt-daemon-system virtinst bridge-utils"
echo $MAHPID
trap _call_janitor SIGKILL SIGTERM SIGINT SIGABRT SIGHUP
logit()
{
	xdate=$(date "+%D %T")
	echo "$xdate $1 " | tee -a ${LOGPATH}
}
fail()
{
	_call_janitor
	logit "$1"
	exit ${2:-666}
}

_call_janitor()
{
	logit "The janitor was called."
	kill -9 $MAHPID
}
install_packages()
{
	logit "Installing ${REQUIRED_PKGS}"
	apt update && apt install ${REQUIRED_PKGS} -y
}

_run_installer()
{
	logit "Starting installer ..."
	logit "Installing packages..."
	install_packages
}
_run_installer
