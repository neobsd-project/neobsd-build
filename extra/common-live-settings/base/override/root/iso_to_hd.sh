#!/bin/sh
# Configure which clean the system after the installation
echo "Starting iso_to_hdd.sh"

if [ -f "/usr/local/bin/mate-session" ]; then
  desktop='mate'
elif [ -f "/usr/local/bin/startxfce4" ]; then
  desktop='xfce'
elif [ -f "/usr/local/bin/gnome-session" ]; then
  desktop='gnome'
fi

remove_neobsd_user()
{
  echo "Remove neobsd user"
  pw userdel -n neobsd -r
  echo "Remove auto login"
  ( echo 'g/# neobsd user autologin' ; echo 'wq' ) | ex -s /etc/gettytab
  ( echo 'g/neobsd:\\"/d' ; echo 'wq' ) | ex -s /etc/gettytab
  ( echo 'g/:al=neobsd:ht:np:sp#115200:/d' ; echo 'wq' ) | ex -s /etc/gettytab
  sed -i "" "/ttyv0/s/neobsd/Pc/g" /etc/ttys
}

setup_dm_and_xinitrc()
{
  echo "setup xinitrc for ${desktop}"
  case $desktop in
    mate)
      echo 'exec mate-session' > /root/.xinitrc
      for user in `ls /usr/home/` ; do
        echo 'exec mate-session' > /usr/home/${user}/.xinitrc
        chown ${user}:${user} /usr/home/${user}/.xinitrc
      done ;;
    xfce)
      echo 'exec startxfce4' > /root/.xinitrc
      for user in `ls /usr/home/` ; do
        echo 'exec startxfce4' > /usr/home/${user}/.xinitrc
        chown ${user}:${user} /usr/home/${user}/.xinitrc
      done ;;
   gnome)
      echo 'exec gnome-session' > /root/.xinitrc
      for user in `ls /usr/home/` ; do
        echo 'exec gnome-session' > /usr/home/${user}/.xinitrc
        chown ${user}:${user} /usr/home/${user}/.xinitrc
      done ;;
  esac

  echo "Enable LightDM at boot"
  # for unknown reason sysrc does not work in this script
  sed -i '' 's/lightdm_enable="NO"/lightdm_enable="YES"/g' /etc/rc.conf
}

restore_settings()
{
  echo "Restore automount_devd.conf and automount_devd_localdisks.conf"
  mv /usr/local/etc/devd/automount_devd.conf.skip /usr/local/etc/devd/automount_devd.conf
  mv /usr/local/etc/devd/automount_devd_localdisks.conf.skip /usr/local/etc/devd/automount_devd_localdisks.conf
}

remove_neobsd_user
setup_dm_and_xinitrc
restore_settings
