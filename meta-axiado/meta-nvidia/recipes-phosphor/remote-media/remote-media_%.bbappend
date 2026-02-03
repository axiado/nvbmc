FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI = "git://github.com/NVIDIA/remote-media;protocol=https;branch=develop"
SRCREV =  "ff52be2b0de82c18d0b0c2c60aa1b520d9ebd115"

# AXBUGS-1872
SRC_URI:append:gb200nvl-bmc-axiado = " file://0001-Enabling-virtual-media-according-to-nvidia-UDC.patch"

SRC_URI:append:gb300nvl-bmc-axiado = " file://0001-Enabling-virtual-media-according-to-nvidia-UDC.patch"

SRC_URI:append:gb200nvl-bmc-axiado-github = " file://0001-Enabling-virtual-media-according-to-nvidia-UDC-github.patch"

