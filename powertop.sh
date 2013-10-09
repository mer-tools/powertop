#!/bin/sh

# Contact: Matti Kosola <matti.kosola@jollamobile.com>
#
# Copyright (c) 2013, Jolla Ltd.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the <organization> nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# /usr/sbin/powertop
# This will start powertop binay, but disable Qualcomm userspace cpu's online
# tracker before launching powertop if mpdecision is running. This also restore
# mpdecision after powertop exit if it was stopped before powertop launch.
#

MPDECISION=$(pidof mpdecision 2>&1)

if [ ! -z "$MPDECISION" ] && [ -x /system/bin/stop ]; then
    /system/bin/stop mpdecision
fi

for online in /sys/devices/system/cpu/cpu*/online;do
    TEMP=$(cat "$online")

    if [ "$TEMP" == "0" ]; then
        /bin/echo 1 > "$online"
    fi
done

/usr/sbin/powertop-original "$@"

if [ ! -z "$MPDECISION" ] && [ -x /system/bin/start ]; then
    /system/bin/start mpdecision
fi
