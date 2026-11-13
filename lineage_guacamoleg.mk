#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from guacamoleg device
$(call inherit-product, device/oneplus/guacamoleg/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_guacamoleg
PRODUCT_DEVICE := guacamoleg
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_MODEL := GM1920
PRODUCT_BRAND := OnePlus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

# The last OxygenOS for the 5G model: 10.0.15, November 2021.
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="OnePlus7ProNR-user 10 QKQ1.190716.003 2111271450 release-keys" \
    BuildFingerprint=OnePlus/OnePlus7ProNR_EEA/OnePlus7ProNR:10/QKQ1.190716.003/2111271450:user/release-keys \
    DeviceName=OnePlus7ProNR \
    DeviceProduct=OnePlus7ProNR_EEA \
    SystemDevice=OnePlus7ProNR \
    SystemName=OnePlus7ProNR_EEA
