### Building a teslausb image

To build a ready to flash one-step setup image for CIFS, do the following:

1. Clone pi-gen from https://github.com/RPi-Distro/pi-gen
1. Follow the instructions in the pi-gen readme to install the required dependencies
1. Copy teslausb/pi-gen-sources/config to pi-gen folder
1. Copy teslausb/pi-gen-sources/stage_teslausb and teslausb/pi-gen-sources/stage_teslawebserver to the pi-gen folder
1. In the pi-gen folder, run:
    ```
    rm -rf stage2/EXPORT_NOOBS
    cp stage2/prerun.sh stage_teslausb/prerun.sh
    cp stage2/prerun.sh stage_teslawebserver/prerun.sh
    ```
1. Copy teslausb/run/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/run folder
1. Copy teslausb/setup/pi/(all files except folders) to pi-gen/stage_teslausb/00-teslausb-tweaks/files/setup-pi folder
1. Copy teslausb/run/cifs_archive folder to pi-gen/stage_teslausb/00-teslausb-tweaks/files folder
1. Copy teslausb/run/none_archive folder to pi-gen/stage_teslausb/00-teslausb-tweaks/files folder
1. Copy teslausb/run/rsync_archive folder to pi-gen/stage_teslausb/00-teslausb-tweaks/files folder
1. Copy teslausb/run/rclone_archive folder to pi-gen/stage_teslausb/00-teslausb-tweaks/files folder
1. Make sure pi-gen/stage_teslausb/00-teslausb-tweaks/02-run.sh and pi-gen/stage_teslawebserver/00-tesla-webserver/01-run.sh files are executable
1. Set credentials for repo url https://$GITHUB_USERNAME:$GITHUB_PASSWORD@github.com/TronCam/RP4.git in pi-gen/stage_teslawebserver/00-tesla-webserver/01-run.sh
```
Replace $GITHUB_USERNAME with your Github username
```
```
Replace $GITHUB_PASSWORD with your Github password
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

1. Run `build-docker.sh` or `CONTINUE=1 PRESERVE_CONTAINER=1 ./build-docker.sh` to preserve docker container
1. This will take a while (around half an hour)
If all went well, the image will be in the `deploy` folder. Use Etcher or similar tool to flash it.
