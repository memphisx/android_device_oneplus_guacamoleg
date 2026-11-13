#
# SPDX-License-Identifier: Apache-2.0
#
# OnePlus 7 Pro 5G (GM1920, OnePlus7ProNR): the OnePlus 7 Pro (guacamole) plus a Qualcomm SDX50M 5G modem.
# Everything comes from guacamole except the device name and the firmware, which is the 5G model's own
# (vendor/oneplus/guacamoleg, made by extract-radio.sh); guacamole's firmware is for a different modem.

# Include the common OEM chipset BoardConfig.
include device/oneplus/sm8150-common/BoardConfigCommon.mk

DEVICE_PATH := device/oneplus/guacamoleg
GUACAMOLE_PATH := device/oneplus/guacamole

# Assert
TARGET_OTA_ASSERT_DEVICE := guacamoleg,OnePlus7ProNR
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Display
TARGET_SCREEN_DENSITY := 560

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/1d84000.ufshc
TARGET_KERNEL_CONFIG += vendor/oplus_non_dynamic.config

# Partitions (the same as the OnePlus 7 Pro)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3640655872
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115601780736
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824

# Properties
TARGET_PRODUCT_PROP += $(GUACAMOLE_PATH)/product.prop
TARGET_VENDOR_PROP += $(GUACAMOLE_PATH)/vendor.prop $(DEVICE_PATH)/vendor.prop

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_FSTAB := $(GUACAMOLE_PATH)/init/fstab.qcom

# Include the proprietary files BoardConfig: the 5G model's firmware.
include vendor/oneplus/guacamoleg/BoardConfigVendor.mk
