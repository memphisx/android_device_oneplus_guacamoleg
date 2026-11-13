#
# SPDX-License-Identifier: Apache-2.0
#

GUACAMOLE_PATH := device/oneplus/guacamole

# AAPT
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio (the OnePlus 7 Pro's)
PRODUCT_COPY_FILES += \
    $(GUACAMOLE_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_ODM)/etc/audio_platform_info.xml \
    $(GUACAMOLE_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_ODM)/etc/mixer_paths.xml \
    $(GUACAMOLE_PATH)/audio/sound_trigger_mixer_paths.xml:$(TARGET_COPY_OUT_ODM)/etc/sound_trigger_mixer_paths.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 3120
TARGET_SCREEN_WIDTH := 1440

# Camera
PRODUCT_PACKAGES += \
    OnePlusCameraHelper

# Device init scripts
PRODUCT_PACKAGES += \
    fstab.qcom \
    fstab.qcom.ramdisk

# The SDX50M: starts its helper, which loads the modem's firmware over PCIe and restarts it after a crash.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/init.guacamoleg.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.guacamoleg.rc

# Fastboot
TARGET_BOARD_FASTBOOT_INFO_FILE := $(GUACAMOLE_PATH)/fastboot-info.txt

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(GUACAMOLE_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    KeyHandlerResTarget \
    OPlusFrameworksResTarget \
    OPlusSettingsProviderResTarget \
    OPlusSettingsResTarget \
    OPlusSystemUIResTarget

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 28

# Soong namespaces: guacamole's modules (fstab, overlays, camera helper)
PRODUCT_SOONG_NAMESPACES += \
    $(GUACAMOLE_PATH)

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm8150-common/common.mk)

# Inherit from the proprietary files makefiles: the OnePlus 7 Pro's blobs, then the 5G model's firmware.
$(call inherit-product, vendor/oneplus/guacamole/guacamole-vendor.mk)
$(call inherit-product, vendor/oneplus/guacamoleg/guacamoleg-vendor.mk)
