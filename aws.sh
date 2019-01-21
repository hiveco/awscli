#!/usr/bin/env bash
set -e

aws_conf=~/.aws/credentials

[ -e $aws_conf ] || ( mkdir -p $(dirname $aws_conf); touch $aws_conf )

region="$AWS_DEFAULT_REGION"
[ -n "$region" ] || region=us-east-1

# Allow running inside scripts that use unix pipes (otherwise Docker complains
# with a "the input device is not a TTY" error):
interactive_mode=""
[[ -t 0 || -p /dev/stdin ]] || interactive_mode="-i"

docker run \
	$interactive_mode \
	-t --rm \
	-v $aws_conf:/root/.aws/credentials \
	-v "$PWD":/here \
	-e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
	-e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
	-e AWS_DEFAULT_REGION=$region \
	hiveco/awscli "$@"

unset aws_conf
unset region
unset interactive_mode
