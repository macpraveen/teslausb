touch "${ROOTFS_DIR}/boot/ssh"
install -m 755 files/rc.local           "${ROOTFS_DIR}/etc/"
install -m 666 files/teslausb_setup_variables.conf.sample    "${ROOTFS_DIR}/boot/"
install -m 666 files/wpa_supplicant.conf.sample    "${ROOTFS_DIR}/boot/"
install -d "${ROOTFS_DIR}/root/bin"
install -m 755 files/enable_wifi.sh "${ROOTFS_DIR}/root/bin"
install -m 755 -D files/run/* "${ROOTFS_DIR}/root/bin"
install -m 755 -D files/setup-pi/* "${ROOTFS_DIR}/root/bin"
install -d "${ROOTFS_DIR}/root/bin/rsync_archive"
install -d "${ROOTFS_DIR}/root/bin/cifs_archive"
install -d "${ROOTFS_DIR}/root/bin/none_archive"
install -d "${ROOTFS_DIR}/root/bin/rclone_archive"
install -m 755 -D files/rsync_archive/* "${ROOTFS_DIR}/root/bin/rsync_archive"
install -m 755 -D files/cifs_archive/* "${ROOTFS_DIR}/root/bin/cifs_archive"
install -m 755 -D files/none_archive/* "${ROOTFS_DIR}/root/bin/none_archive"
install -m 755 -D files/rclone_archive/* "${ROOTFS_DIR}/root/bin/rclone_archive"

on_chroot << EOF
pip3 install boto3
EOF