#!/bin/bash

SETUP_THEOS=0

export RACROSS_BASE=`pwd`

export RACROSS_CACHE=${RACROSS_BASE}/cache
rm -rf ${RACROSS_CACHE}
mkdir -p ${RACROSS_CACHE}

export RACROSS_TOOLS=${HOME}/RAcross-tools
rm -rf ${RACROSS_TOOLS}
mkdir -p ${RACROSS_TOOLS}

RACROSS_INITSCRIPT=~/.profile

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install mas ldid xz

#mas signin someone@mail.com password

# XCode
mas install 497799835
sudo xcodebuild -license
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Theos
if [ ${SETUP_THEOS} = 1 ] ; then
cd ${RACROSS_BASE}
export THEOS=${RACROSS_TOOLS}/theos
echo "export THEOS=${RACROSS_TOOLS}/theos" >> ~/.profile
git clone --recursive https://github.com/theos/theos.git ${THEOS}
rm -rf ${THEOS}/sdks
git clone --depth=1 https://github.com/theos/sdks.git ${THEOS}/sdks
curl https://ghostbin.com/ghost.sh -o ${THEOS}/bin/ghost
chmod +x ${THEOS}/bin/ghost
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
git clone --depth=1 https://github.com/libretro/libretro-super.git
tar Jcvf ${RACROSS_CACHE}/libretro-super.tar.xz libretro-super

# build scripts
cp ${RACROSS_BASE}/build-core.sh ~/libretro-super/

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

