# Arkodi

Build tool for Archlinux ARM plus Kodi for Raspberry Pi.

```Shell
$ ./arkodi -h
Install Arch and Kodi on a SD Card
Usage:
  ./arkodi [OPTION [VALUE]]... DRIVE
Options:
  -c  [filename] use config file
  -p  [[rpi]|rpi-2] platform
  -h  show this help and quit
Example:
  ./arkodi -p rpi-2 /dev/mmcblk0
```

## Example of usage.

```Shell
# Generate configuration file.
$ ./firstrun/generate > arkodi.cfg
```

Then edit this file (un)commenting the desired options.

```Shell
# Configuration example, only lines with no '#' will be applied.

base/00-wait_connection
base/10-full-system-update
base/30-kodi
base/99-firstrun_disable
recommended/00-mounts-noatime
recommended/00-ssh_as_root
rpi_rpi-2/00-physical_keyboard
rpi_rpi-2/30-hardware-acceleration
rpi_rpi-2/40-lirc_rpi
rpi/00-gpu_mem
# optional/00-fixed_hdmi
# optional/00-overscan_panassonic_42pv80
# optional/00-overscan_samsung
## Usage: optional/30-static-ip eth0 192.168.0.101/24 192.168.0.1
# optional/00-static-ip
## Usage: optional/30-swapfile 1GiB
# optional/00-swapfile
# optional/40-lirc
# optional/40-lirc_samsung_bn98
# optional/40-liveroot
# optional/80-fuse-allow-other
```

Now run the script to create the arkodi sdcard.

```Shell
./arkodi -c arkodi.cfg -p rpi-2 /dev/mmcblk0
```
