#!/bin/bash

SETUP_THEOS=0
SETUP_ANDROID=0
SETUP_EMSCRIPTEN=0

RACROSS_SETUP_DELETE=1

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

brew install mas ldid xz wget nodejs cmake

#mas signin someone@mail.com password

# XCode
mas install 497799835
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
git
sudo xcodebuild -license

# Theos
if [ ${SETUP_THEOS} = 1 ] ; then
	echo "*** setup Theos ***"
	cd ${RACROSS_BASE}
	export THEOS=${RACROSS_TOOLS}/theos
	echo "export THEOS=${RACROSS_TOOLS}/theos" >> ${RACROSS_INITSCRIPT}
	git clone --recursive https://github.com/theos/theos.git ${THEOS}
	rm -rf ${THEOS}/sdks
	git clone --depth=1 https://github.com/theos/sdks.git ${THEOS}/sdks
	curl https://ghostbin.com/ghost.sh -o ${THEOS}/bin/ghost
	chmod +x ${THEOS}/bin/ghost
#	if [ ! ${RACROSS_SETUP_DELETE} = 1 ] ; then
#		tar Jcvf ${RACROSS_CACHE}/theos.tar.xz ${THEOS}
#	fi
fi

# Emscripten
if [ ${SETUP_EMSCRIPTEN} = 1 ] ; then
	echo "*** setup Emscripten ***"
	cd ${RACROSS_TOOLS}
	git clone --depth=1 https://github.com/emscripten-core/emsdk.git
	cd emsdk
	./emsdk update
	git pull
	./emsdk install latest
	./emsdk activate latest
#	source ./emsdk_env.sh
#	echo "source ${RACROSS_TOOLS}/emsdk/emsdk_env.sh" >> ${RACROSS_INITSCRIPT}
fi

# Android NDK
if [ ${SETUP_ANDROID} = 1 ] ; then
	echo "*** setup Android NDK ***"
	cd ${RACROSS_BASE}
	wget https://dl.google.com/android/repository/android-ndk-r20-darwin-x86_64.zip -P ${RACROSS_CACHE}
	unzip ${RACROSS_CACHE}/android-ndk-r20-darwin-x86_64.zip -d ${RACROSS_TOOLS}/
	export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r20
	export PATH=$PATH:${RACROSS_TOOLS}/android-ndk-r20
	echo "export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r20" >> ${RACROSS_INITSCRIPT}
	echo "export PATH=\$PATH:${RACROSS_TOOLS}/android-ndk-r20" >> ${RACROSS_INITSCRIPT}
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
git clone --depth=1 https://github.com/AZO234/libretro-super.git
cd libretro-super
git checkout fix
cd ..
#tar Jcvf ${RACROSS_CACHE}/libretro-super.tar.xz libretro-super

# build scripts
cp ${RACROSS_BASE}/build-core.sh ~/libretro-super/

cd ~
if [ ${RACROSS_SETUP_DELETE} = 1 ] ; then
	rm -rf ${RACROSS_BASE}
fi

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

