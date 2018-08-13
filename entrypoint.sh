#!/bin/sh

if [ "$AWS_DEFAULT_REGION" = "" ]; then

	availability_zone=$(wget \
		-t 2 \
		--timeout=0.5 \
		--retry-connrefused \
		--waitretry=0 \
		--quiet \
		-O - \
		http://169.254.169.254/latest/meta-data/placement/availability-zone)

	if [ $? -eq 0 ]; then
		export AWS_DEFAULT_REGION="$(echo "$availability_zone" | sed 's/\(.*\)[a-z]/\1/')"
	else
		echo >&2 "Timeout reading EC2 metadata, defaulting to us-east-1 region. Specify AWS_DEFAULT_REGION explicitly for faster operation next time."
		export AWS_DEFAULT_REGION="us-east-1"
	fi

fi

exec aws "$@"
