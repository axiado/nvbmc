S = "${WORKDIR}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
           file://reset_cx7_mcu.sh \
          "

do_install:append() {
    install -m 0755 ${WORKDIR}/reset_cx7_mcu.sh ${D}${bindir}/
}