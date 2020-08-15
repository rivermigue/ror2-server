#!/bin/bash
rm -rf dosdevices drive_c system.reg .update-timestamp user.reg userdef.reg
/usr/bin/docker run --rm $*
