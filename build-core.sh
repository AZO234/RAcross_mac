#!/bin/bash

BUILD_THEOS=1
BUILD_ANDROID=1
BUILD_EMSCRIPTEN=1

LR_CORE=np2kai
LR_CORE_SRC=~/NP2kai

LR_DISTLOG_CLEAN=1
LR_SRC_FETCH=0

cd ~/libretro-super

if [[ ${LR_DISTLOG_CLEAN} = 1 ]] ; then
rm -rf dist/*
rm -rf log/*
fi

unset CC
unset CXX
unset AR
unset LD

# host(macOS x86_64)
rm -rf libretro-${LR_CORE}
echo "=== host - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build.sh ${LR_CORE}
echo "=== host - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_host.log

# iOS
rm -rf libretro-${LR_CORE}
echo "=== iOS - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ios.sh ${LR_CORE}
echo "=== iOS - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ios.log

# iOS9
rm -rf libretro-${LR_CORE}
echo "=== iOS9 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ios9.sh ${LR_CORE}
echo "=== iOS9 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ios9.log

# iOS ARM64
rm -rf libretro-${LR_CORE}
echo "=== iOS ARM64 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ios-arm64.sh ${LR_CORE}
echo "=== iOS ARM64 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ios-arm64.log

# tvOS ARM64
rm -rf libretro-${LR_CORE}
echo "=== tvOS ARM64 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-tvos-arm64.sh ${LR_CORE}
echo "=== tvOS ARM64 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_tvos-arm64.log

# iOS Theos
if [[ ${BUILD_THEOS} = 1 ]] ; then
	rm -rf libretro-${LR_CORE}
	echo "=== iOS Theos - build start ==="
	if [[ ${LR_SRC_FETCH} = 1 ]] ; then
	./libretro-fetch.sh ${LR_CORE}
	else
	cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
	fi
	./libretro-build-ios-theos.sh ${LR_CORE}
	echo "=== iOS Theos - build end ==="
	mv log/${LR_CORE}.log log/${LR_CORE}_ios-theos.log
fi

# android-mk
if [[ ${BUILD_ANDROID} = 1 ]] ; then
	rm -rf libretro-${LR_CORE}
	echo "=== android-mk - build start ==="
	if [[ ${LR_SRC_FETCH} = 1 ]] ; then
	./libretro-fetch.sh ${LR_CORE}
	else
	cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
	fi
	./libretro-build-android-mk.sh ${LR_CORE} 2>&1 | tee log/${LR_CORE}_android.log
	echo "=== android-mk - build end ==="
fi

# Emscripten
if [[ ${BUILD_EMSCRIPTEN} = 1 ]] ; then
	source ${RACROSS_TOOLS}/emsdk/emsdk_env.sh
	rm -rf libretro-${LR_CORE}
	echo "=== Emscripten - build start ==="
	if [[ ${LR_SRC_FETCH} = 1 ]] ; then
	./libretro-fetch.sh ${LR_CORE}
	else
	cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
	fi
	./libretro-build-emscripten.sh ${LR_CORE}
	echo "=== Emscripten - build end ==="
	mv log/${LR_CORE}.log log/${LR_CORE}_emscripten.log
fi

unset CC
unset CXX
unset AR
unset LD

