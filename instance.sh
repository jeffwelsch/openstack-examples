#!/usr/bin/env bash 

source ~/credentials/demo-jeffwelsch/openrc.sh

set -x

nova list
nova boot --flavor n1.small --image "Ubuntu 14.04" test-instance
nova list
nova delete test-instance
nova list
