#!/bin/sh

set -e -u

default_neobsd_rc_conf()
{
  cp  ${release}/etc/rc.conf ${release}/etc/rc.conf.neobsd
}

set_sudoers()
{
  sed -i "" -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' ${release}/usr/local/etc/sudoers
  sed -i "" -e 's/# %sudo/%sudo/g' ${release}/usr/local/etc/sudoers
}

final_setup()
{
  default_neobsd_rc_conf
  set_sudoers
}
