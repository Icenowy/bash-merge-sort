#! /bin/bash
# Copyright (C) Icenowy Zheng <icenowy@aosc.io>

if [ $# = 0 ]; then
	exit 0
elif [ $# = 1 ]; then
	printf "%s\n" "$1"
else
	part1_size=`expr $# / 2`
	part2_size=`expr $# - $part1_size`

	part1="$1"
	part1_remaining=`expr $part1_size - 1`
	shift
	while [ $part1_remaining -gt 0 ]; do
		part1="$part1 $1"
		part1_remaining=`expr $part1_remaining - 1`
		shift
	done
	part2="$@"

	part1_sorted="$(bash $0 $part1)"
	part2_sorted="$(bash $0 $part2)"

	for i in $part1_sorted; do
		for j in $part2_sorted; do
			if [ "$j" -lt "$i" ]; then
				printf "%s " "$j"
				if echo $part2_sorted | grep -q ' '; then
					part2_sorted="$(echo $part2_sorted | cut -d ' ' -f 2-)"
				else
					part2_sorted=""
				fi
			else
				break
			fi
		done
		printf "%s " "$i"
	done

	if [ "$part2_sorted" != "" ]; then
		printf "$part2_sorted"
	fi
	echo
fi
