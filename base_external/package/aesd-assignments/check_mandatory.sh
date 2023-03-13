# Reference
# https://buildroot.org/downloads/manual/manual.html#requirement-mandatory#

# Build tools:
#
#    which
#    sed
#    make (version 3.81 or any later)
#    binutils
#    build-essential (only for Debian based systems)
#    diffutils
#    gcc (version 4.8 or any later)
#    g++ (version 4.8 or any later)
#    bash
#    patch
#    gzip
#    bzip2
#    perl (version 5.8.7 or any later)
#    tar
#    cpio
#    unzip
#    rsync
#    file (must be in /usr/bin/file)
#    bc
#    findutils
#
#  Source fetching tools:
#
#    wget

function existed () {

    local package=${1:?}
    echo "The $package was installed."
	return 0
}

for package in which sed make binutils build-essential diffutils gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc findutils wget;
do
    which $package > /dev/null && existed $package ||  { apt list --installed 2> /dev/null | grep -q $package  && existed $package ; } || { echo "790813" | sudo -S apt update && sudo apt -y upgrade && sudo apt -y install $package; }
done
