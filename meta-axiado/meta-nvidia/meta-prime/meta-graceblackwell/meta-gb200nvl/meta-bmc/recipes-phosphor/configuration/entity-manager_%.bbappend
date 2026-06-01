FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://Carlo_E1.s_BP.json \
            file://Carlo_IPEX.json \
            file://Carlo_NIC.json \
            file://Carlo_OSFP.json \
            file://Chassis_Carlo_1RU.json \
            file://PDB_PEGA.json \
            "

do_install:append() {
     install -m 0444 ${WORKDIR}/Carlo_E1.s_BP.json ${D}/usr/share/entity-manager/configurations
     install -m 0444 ${WORKDIR}/Carlo_IPEX.json ${D}/usr/share/entity-manager/configurations
     install -m 0444 ${WORKDIR}/Carlo_NIC.json ${D}/usr/share/entity-manager/configurations
     install -m 0444 ${WORKDIR}/Carlo_OSFP.json ${D}/usr/share/entity-manager/configurations
     install -m 0444 ${WORKDIR}/Chassis_Carlo_1RU.json ${D}/usr/share/entity-manager/configurations
     install -m 0444 ${WORKDIR}/PDB_PEGA.json ${D}/usr/share/entity-manager/configurations
}
