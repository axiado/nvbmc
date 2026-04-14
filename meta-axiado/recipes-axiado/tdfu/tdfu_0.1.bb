# Copyright (c) 2021-26 Axiado Corporation (or its affiliates). All rights reserved.

SUMMARY = "tdfu"
DESCRIPTION = "TCU Firmware Upgrade Application"
LICENSE = "CLOSED"
PV = "0.1"

SRC_URI = "file://ax3000-fw-update"

INSANE_SKIP:${PN} += "already-stripped"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${UNPACKDIR}/ax3000-fw-update ${D}${bindir}
}
