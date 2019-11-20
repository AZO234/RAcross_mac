RAcross_mac
===========

RAcross is libretro(RA?)'s core cross build emvironment.

	- Use macOS 10.15.1 Catalina (Vanilla)

RAcross_mac can test follow cross builds

	- host
	- iOS
	- iOS 9
	- iOS ARM64
	- tvOS ARM64

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

	1. login to Apple store
	2. open terminal
	3. locate your core source at /home/USER/
	4. edit libretro-super/build-core.sh, LR_CORE and LR_CORE_SRC value
	5. cd libretro-super
	6. ./build-core.sh
	7. build logs are output in 'log' dir  
	binalys are output in 'dist' dir

