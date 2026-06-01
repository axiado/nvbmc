# Nvidia released a pre-bulit executable on Github which is not compatible with Axiado TCU
# So we shouldn't install this package for all BMC HMC and PMC
OBMC_IMAGE_EXTRA_INSTALL:remove = "nvidia-bmc-compliance"

# Required for BMC Firmware Update
IMAGE_INSTALL:append = " nvidia-code-mgmt"
