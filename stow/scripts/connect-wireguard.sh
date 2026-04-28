#!/usr/bin/bash

set -ex
sudo nmcli connection down wg0
sudo wg-quick up wg0
