#!/bin/sh

# update the system
apt-get update
apt-get upgrade

################################################################################
# Install the mandatory tools
################################################################################
echo "# =========== INSTALL mandatory tools =========== "
export LANGUAGE='pt_BR.UTF-8'
export LANG='pt_BR.UTF-8'
export LC_ALL='pt_BR.UTF-8'
locale-gen pt_BR.UTF-8

# install utilities
apt-get -y install vim zip bzip2 fontconfig curl language-pack-gnome-pt language-pack-pt-base

# dpkg-reconfigure locales
# dpkg-reconfigure keyboard-configuration
L='br' && sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard

# install Git, Maven and Java 8
apt-get -y install git maven openjdk-8-jdk

################################################################################
# Install the development tools
################################################################################
echo "# =========== INSTALL development tools =========== "
# install Ubuntu Make - see https://wiki.ubuntu.com/ubuntu-make
apt-get install -y ubuntu-make libgconf-2-4

# install Chromium Browser
apt-get install -y chromium-browser

# install Visual Studio Code
su -c 'umake ide visual-studio-code /home/vagrant/.local/share/umake/ide/visual-studio-code --accept-license' vagrant

# fix links (see https://github.com/ubuntu/ubuntu-make/issues/343)
sed -i -e 's/visual-studio-code\/code/visual-studio-code\/bin\/code/' /home/vagrant/.local/share/applications/visual-studio-code.desktop

# disable GPU (see https://code.visualstudio.com/docs/supporting/faq#_vs-code-main-window-is-blank)
sed -i -e 's/"$CLI" "$@"/"$CLI" "--disable-gpu" "$@"/' /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code

#install IDEA community edition
su -c 'umake ide idea /home/vagrant/.local/share/umake/ide/idea' vagrant

# increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
sysctl -p --system

# install latest Docker
curl -sL https://get.docker.io/ | sh

# install latest docker-compose
curl -L "$(curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | head -n 4 | grep Linux | grep -v sha256 | cut -d '"' -f 4)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# configure docker group (docker commands can be launched without sudo)
usermod -aG docker vagrant

################################################################################
# Install the graphical environment
################################################################################
# force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

apt-get -y install ubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# fix ownership of home
chown -R vagrant:vagrant /home/vagrant/

# clean the box
# apt-get -y autoclean
# apt-get -y clean
# apt-get -y autoremove
# dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
# rm -f /EMPTY
