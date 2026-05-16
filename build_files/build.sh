#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

### rtw69 (morrownr/rtw89)
# requirements (already installed)
# dnf5 install -y make gcc kernel-devel kernel-headers 
dnf5 install -y dkms 
# clone repo
git clone https://github.com/morrownr/rtw89
cd rtw89
# clean up
# make cleanup_target_system
# build & install
dkms install $(pwd)
make install_fw
# configurate
cp -v rtw89.conf /etc/modprobe.d/
# go back
cd ..
rm -rf rtw89

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
