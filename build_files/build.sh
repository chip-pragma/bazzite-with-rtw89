#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

### rtw89 (morrownr/rtw89)

# requirements (already installed)
# dnf5 install -y make gcc kernel-devel kernel-headers

# clone repo (forked & synced)
git clone https://github.com/chip-pragma/rtw89.git
cd rtw89
# prepare
export KVER="$(rpm -q 'kernel' --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
# clean up
make cleanup_target_system
make clean 
# build & install
make modules
make install
make install_fw
# configurate
cp -v rtw89.conf /etc/modprobe.d/
# cleanup
cd ..
rm -rf rtw89

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
