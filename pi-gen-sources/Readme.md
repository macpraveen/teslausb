### Building a teslausb image

To build a ready to flash one-step setup image for CIFS, do the following:

1. Clone pi-gen from https://github.com/RPi-Distro/pi-gen
1. Follow the instructions in the pi-gen readme to install the required dependencies
1. In the pi-gen folder, run:
    ```
    rm -rf stage2/EXPORT_NOOBS
    cp stage2/prerun.sh stage_teslausb/prerun.sh
    cp stage2/prerun.sh stage_teslawebserver/prerun.sh
    ```
1. Copy teslausb/pi-gen-sources/stage_teslausb and teslausb/pi-gen-sources/stage_teslawebserver to the pi-gen folder
1. Copy teslausb/run/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run folder
1. Copy teslausb/setup/pi/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/setup-pi folder
1. Copy teslausb/run/cifs_archive/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run/cifs_archive folder
1. Copy teslausb/run/none_archive/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run/none_archive folder
1. Copy teslausb/run/rsync_archive/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run/rsync_archive folder
1. Copy teslausb/run/rclone_archive/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run/rclone_archive folder
1. Make sure 02-run.sh and 00-run.sh files are executable
1. Set ENV vars for repo url https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/TronCam/RP4.git
```
export GITHUB_USERNAME='Github username'
```
```
export GITHUB_PASSWORD='Github password'
```
1. In pi-gen Dockerfile change the below line from
```
FROM debian:buster
```

to
```
FROM i386/debian:buster
```

This is due to this https://github.com/RPi-Distro/pi-gen/issues/271

1. Run `build-docker.sh`
1. Sit back and relax, this could take a while (for reference, on a dual-core 2.6 Ghz Intel Core i3 and 50 Mbps internet connection, it took under an hour)
If all went well, the image will be in the `deploy` folder. Use Etcher or similar tool to flash it.
