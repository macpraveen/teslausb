#! /bin/bash -eu
# This is a standalone script to just manually trigger
# the steps to enable wifi so you don't have to run rc.local
#
# This is probably a model to follow, similar to some of the
# reorganization work going on with the main scripts.

HEADLESS_SETUP=true

if [ -e "/boot/teslausb-headless-setup.log" ]
then
    HEADLESS_SETUP=true
fi


function setup_progress () {
  if [ $HEADLESS_SETUP = "true" ]
  then
    SETUP_LOGFILE=/boot/teslausb-headless-setup.log
    echo "$( date ) : $1" >> "$SETUP_LOGFILE"
  fi
    echo "$1"
}

function enable_wifi () {
  setup_progress "Detecting whether to update wpa_supplicant.conf"
  if [ -n "${SSID+x}" ] && [ -n "${WIFIPASS+x}" ]
  then
      if [ ! -e /boot/WIFI_ENABLED ]
      then
        if [ -e /root/bin/remountfs_rw ]
        then
          /root/bin/remountfs_rw
        fi
        setup_progress "Wifi variables specified, and no /boot/WIFI_ENABLED. Building wpa_supplicant.conf."
        cp /boot/wpa_supplicant.conf.sample /boot/wpa_supplicant.conf
        sed -i'.bak' -e "s/TEMPSSID/${SSID}/g" /boot/wpa_supplicant.conf
        sed -i'.bak' -e "s/TEMPPASS/${WIFIPASS}/g" /boot/wpa_supplicant.conf
        cp /boot/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
        

        if [ -e "/root/teslausb_setup_variables.conf" ]
        then
          source "/root/teslausb_setup_variables.conf"
        fi

        # set the host name now if possible, so it's effective immediately after the reboot
        local old_host_name
        old_host_name=$(cat /etc/hostname)
        if [[ -n "$TESLAUSB_HOSTNAME" ]] && [[ "$TESLAUSB_HOSTNAME" != "$old_host_name" ]]
        then
          local new_host_name="$TESLAUSB_HOSTNAME"
          sed -i -e "s/$old_host_name/$new_host_name/g" /etc/hosts
          sed -i -e "s/$old_host_name/$new_host_name/g" /etc/hostname
        fi

        # add ID string to wpa_supplicant
        if ! grep -q id_str /etc/wpa_supplicant/wpa_supplicant.conf
        then
          sed -i -e 's/}/  id_str="AP1"\n}/'  /etc/wpa_supplicant/wpa_supplicant.conf
        fi
        
        touch /boot/WIFI_ENABLED
        setup_progress "Rebooting..."
        reboot
      fi
  else
    echo "You need to export your desired SSID and WIFI pass like:"
    echo "  export SSID=your_ssid"
    echo "  export WIFIPASS=your_wifi_pass"
    echo ""
    echo "Then re-run enable_wifi.sh"

  fi
}

enable_wifi
