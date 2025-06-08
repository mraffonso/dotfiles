#!/bin/bash

# muxstat.sh -- system stats for tmux status line

MUXSTAT_VERSION="0.1.0"

print_error() {
	msg=$1
	exit_code=${2:-1}
	echo "muxstat: $msg"
	exit $exit_code
}

print_usage() {
	exit_code=${1:-0}
	echo "Usage: muxstat <command> [<args>...]"
	echo
	echo "Commands:"
	echo "    processor        show processor usage"
	echo "    memory           show memory usage"
	echo "    volume           show volume level"
	echo
	echo "    help             show help text"
	echo "    version          show version number"
	echo
	echo "For full documentation, see https://github.com/mraffonso/dotfiles#readme"
	exit $exit_code
}

print_version() {
	echo "muxstat $MUXSTAT_VERSION"
}

print_processor() {
	# TODO: Improve this calculation
	cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else printf("%.2f", ($2+$4-u1) * 100 / (t-t1)); }' \
		<(grep 'cpu ' /proc/stat) <(sleep 0.025; grep 'cpu ' /proc/stat))
	echo "💻 ${cpu_usage}%"
}

memory_free() {
	echo "$(free -m | awk 'FNR == 2 {printf("%.1f", $7/1000)}')"
}

memory_total() {
	echo "$(free -m | awk 'FNR == 2 {printf("%.1f", $2/1000)}')"
}


memory_used() {
	echo "$(free -m | awk 'FNR == 2 {printf("%.1f", ($2-$7)/1000)}')"
}


print_memory() {
	echo "🐏 $(memory_used)/$(memory_total) GiB"
}

volume_usage() {
	output=$(amixer sget Master | awk -F"[][]" '/Front Left/ { print $2 }')
	echo "${output//[$'\t\r\n ']}"
}

volume_muted() {
	muted_status=$(amixer sget Master | awk -F"[][]" '/Front Left/ { print $4 }')
	if [ "${muted_status//[$'\t\r\n ']}" == "off" ]; then
		echo "0" && return
	fi

	echo "1"
}

print_volume_icon() {
	percentage=$(volume_usage)
	value=$(expr "${percentage//%}" + 0)
	if [ $value -eq 0 ]; then
		echo "🔇"
	elif [ $value -gt 0 ] && [ $value -lt 34 ]; then
		echo "🔈"
	elif [ $value -gt 33 ] && [ $value -lt 67 ]; then
		echo "🔉"
	else
		echo "🔊"
	fi
}

print_volume() {
	if [ "$(volume_muted)" == "0" ];then
		echo "🔇 mute" && return
	fi
	echo "$(print_volume_icon) $(volume_usage)"
}

if [ $# -eq 0 ]; then
	print_usage 1
else
	case $1 in
		processor|proc|cpu)
			print_processor
			;;
		memory|mem|ram)
			print_memory
			;;
		volume|vol|sound|audio)
			print_volume
			;;
		help|--help|-h)
			print_usage
			;;
		version|ver|--version|-v)
			print_version
			;;
		*)
			print_error "unknown command '$1'"
			;;
	esac
fi
