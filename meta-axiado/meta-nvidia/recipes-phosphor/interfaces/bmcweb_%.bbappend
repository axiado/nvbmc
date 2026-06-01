FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
#SRC_URI = "git://github.com/NVIDIA/bmcweb;protocol=https;branch=develop"
#SRCREV = "95a02a04c533290c6e42016594a646ec6d6b0d9b"
# AXBUGS-1713
#SRC_URI += "file://0001-AXBUGS-1713-1763-1814-removed-irregularities-in-role.patch \
#            file://0002-AXBUGS-2410-Fix-to-create-triggers.patch \
#           "

#FIXME
#SRC_URI += "file://0001-KWS-6639-RedfishSupportForScreenCapture.patch \
#            file://0001-NvidiaManager-v1-xml.patch

# Enable SNMP/SMTP
#EXTRA_OECMAKE:append = " -DBMCWEB_ENABLE_REDFISH_SNMP=ON "

# Enable KVM
EXTRA_OEMESON:append = " -Dkvm=enabled"

CXX += "-Wno-error=free-nonheap-object"
