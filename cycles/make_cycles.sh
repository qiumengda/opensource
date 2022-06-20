
function install_dependencies()
{
	sudo apt-get install git cmake
	sudo apt-get install build-essential
	sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev libglut-dev
	sudo apt-get install freeglut3-dev libxmu-dev libxi-dev
	sudo apt-get install libglew-dev
	sudo apt-get install libboost-all-dev
	sudo apt-get install libopenimageio-dev
	sudo apt-get install libopenexr-dev
	sudo apt-get install libpugixml-dev
	sudo apt-get install libosl-dev            # For openShadingLanguage
	sudo apt-get install libgoogle-glog-dev    # For Logging
}

function init()
{	
	install_dependencies
	git clone git://git.blender.org/cycles.git
}

function fix_build_error()
{
	FILE=src/util/util_ies.cpp
	grep "algorithm" $FILE
	if [ ! $? -eq 0 ]; then
		echo "$FILE need to fix"
		sed -i '/util_foreach.h/i#include <algorithm>' $FILE
	else
		echo "$FILE Alread fixed"
	fi

	FILE=src/util/util_guarded_allocator.h
	grep "stdlib" $FILE
	if [ ! $? -eq 0 ]; then
		echo "$FILE need to Fix"
		sed -i '/cstddef/i#include <stdlib.h>' $FILE
	else
		echo "$FILE Alread Fixed"
	fi
}

function build()
{

	cd cycles
	fix_build_error
	make debug
	cd -
}

function main()
{
	#set -x 

	case $1 in
	"init")
		init
		;;
	*)
		build
		;;
	esac
}

main $1
