FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI = "git://github.com/NVIDIA/bmcweb;protocol=https;branch=develop"
SRCREV = "8d0cc43d1e5afc0461fc1e48d438e03c4d41bd2d"
# AXBUGS-1713
SRC_URI += "file://0001-AXBUGS-1713-1763-1814-removed-irregularities-in-role.patch"

#FIXME
#SRC_URI += "file://0001-KWS-6639-RedfishSupportForScreenCapture.patch \
#            file://0001-NvidiaManager-v1-xml.patch

CXX += "-Wno-error=free-nonheap-object"
