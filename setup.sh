#!/bin/bash

SETUP_THEOS=1
SETUP_ANDROID=1
SETUP_EMSCRIPTEN=1

RACROSS_SETUP_GIT=0

RACROSS_SETUP_DELETE=1

export RACROSS_BASE=`pwd`

export RACROSS_CACHE=${RACROSS_BASE}/cache
rm -rf ${RACROSS_CACHE}
mkdir -p ${RACROSS_CACHE}

export RACROSS_TOOLS=${HOME}/RAcross-tools
rm -rf ${RACROSS_TOOLS}
mkdir -p ${RACROSS_TOOLS}

RACROSS_INITSCRIPT=${HOME}/.zprofile

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install gpatch mas ldid xz wget nodejs cmake ninja sdl sdl_mixer sdl_ttf sdl2 sdl2_mixer sdl2_ttf libusb wxwidgets mercurial

#mas signin someone@mail.com password

# XCode
mas install 497799835
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
git
sudo xcodebuild -license

if [[ ${RACROSS_SETUP_GIT} = 1 ]] ; then
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
fi

# Theos
if [[ ${SETUP_THEOS} = 1 ]] ; then
	echo "*** setup Theos ***"
	cd ${RACROSS_BASE}
	export THEOS=${RACROSS_TOOLS}/theos
	echo "export THEOS=${RACROSS_TOOLS}/theos" >> ${RACROSS_INITSCRIPT}
	git clone https://github.com/theos/theos.git ${THEOS}
	cd ${THEOS}
	git remote add AZO234 https://github.com/AZO234/theos.git
	git pull --no-edit AZO234 fix
	git submodule update --init --recursive
	cd ${RACROSS_BASE}
	rm -rf ${THEOS}/sdks
	git clone https://github.com/hirakujira/sdks.git ${THEOS}/sdks
	if [[ ! ${RACROSS_SETUP_DELETE} = 1 ]] ; then
		tar Jcvf ${RACROSS_CACHE}/theos.tar.xz ${THEOS}
	fi
fi

# Emscripten
if [[ ${SETUP_EMSCRIPTEN} = 1 ]] ; then
	echo "*** setup Emscripten ***"
	cd ${RACROSS_TOOLS}
	git clone https://github.com/emscripten-core/emsdk.git
	cd emsdk
	./emsdk update
	git pull
	./emsdk install latest
	./emsdk activate latest
#	source ./emsdk_env.sh
#	echo "source ${RACROSS_TOOLS}/emsdk/emsdk_env.sh" >> ${RACROSS_INITSCRIPT}
fi

# Android NDK
if [[ ${SETUP_ANDROID} = 1 ]] ; then
	echo "*** setup Android NDK ***"
	cd ${RACROSS_BASE}
	wget https://dl.google.com/android/repository/android-ndk-r21b-darwin-x86_64.zip -P ${RACROSS_CACHE}
	unzip ${RACROSS_CACHE}/android-ndk-r21b-darwin-x86_64.zip -d ${RACROSS_TOOLS}/
	export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21b
	export PATH=$PATH:${RACROSS_TOOLS}/android-ndk-r21b
	echo "export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21b" >> ${RACROSS_INITSCRIPT}
	echo "export PATH=\$PATH:${RACROSS_TOOLS}/android-ndk-r21b" >> ${RACROSS_INITSCRIPT}
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
git clone https://github.com/libretro/libretro-super.git
cd libretro-super
git remote add AZO234 https://github.com/AZO234/libretro-super.git
git pull --no-edit AZO234 AZO_fix
cd ..
#tar Jcvf ${RACROSS_CACHE}/libretro-super.tar.xz libretro-super

# build scripts
cp ${RACROSS_BASE}/build-core.sh ~/libretro-super/

cd ~
if [[ ${RACROSS_SETUP_DELETE} = 1 ]] ; then
	rm -rf ${RACROSS_BASE}
fi

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

