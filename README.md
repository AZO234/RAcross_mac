RAcross_mac
===========

RAcross is libretro(RA?)'s core cross build emvironment.

	- Use macOS 10.14.3 Mojave (Vanilla)

RAcross_mac can test follow cross builds

	- host
	- iOS
	- iOS 9
	- iOS ARM64


install
-------

	1. Locate RAcross_mac directory on home dir
	2. login App Store
	3. setup with terminal

		1. Finder -> "Location" -> "Utility" -> "terminal"
		2. cd RAcross_mac
		3. ./setup.sh

		- Homebrew
		- Xcode (after installed, You must agree)

	4. "RAcross setup is finished." displaied then close terminal and reboot

usage
-----

	1. open terminal
	2. locate your core source at /home/USER/
	3. edit libretro-super/build-core.sh, LR_CORE and LR_CORE_SRC value
	4. cd libretro-super
	5. ./build-core.sh
	6. build logs are output in log dir

