#!/bin/sh -l

set -e

sh -c "echo $* | /talisman --githook pre-push"
