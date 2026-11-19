# OnePlus 7 Pro 5G (guacamoleg)

LineageOS device tree for the OnePlus 7 Pro 5G (GM1920, `OnePlus7ProNR`), which LineageOS has never supported.

The 5G model is a OnePlus 7 Pro (`guacamole`, official on lineage-24.0) with a second modem: a Qualcomm SDX50M on
PCIe, for 5G. This tree builds on guacamole and changes only what differs:

- **Device name**: `guacamoleg`; the zip installs on `OnePlus7ProNR` and nothing else.
- **Firmware**: the 5G model's own, from its last OxygenOS (10.0.15, November 2021). The modem image carries the
  SDX50M's firmware (`image/sdx50m`); the OnePlus 7 Pro's firmware is for a different modem and is never used.
- **The SDX50M**: the kernel's esoc driver (off in `oplus.config`, on again in `vendor/guacamoleg.config`) powers it on;
  `init.guacamoleg.rc` starts `vendor.mdm_helper`, which sends it its firmware with `ks`. The loader (`mdm_helper`, `ks`,
  `libmdmimgload`, `libmdmdetect`) is the 5G model's own, from OxygenOS 10.0.15: the OnePlus 7 Pro's does not know
  project 18827 and leaves out an image the SDX50M asks for, and the esoc driver then crashes the phone.
  `patches/vendor_oneplus_sm8150-common` makes sm8150-common's modules install it.
- **5G radio settings** from OxygenOS 10.0.15 (`vendor.prop`), and 5G in the default network types (33, not 22).
- **Kernel** (`patches/kernel_oneplus_sm8150`, applied with `patches/apply.sh <tree>` after `repo sync`):
  - the 5G model's own dtbo overlay (18827, with the SDX50M): its OxygenOS 10 bootloader picks an overlay by
    `oem,project-id` and `oem,hw-id`, and without one of its own it falls back to the 7 Pro's, which has no 5G modem;
  - the project number from the OnePlus project info when the bootloader is older than OxygenOS 11: otherwise every
    driver that asks for it (display, touch, sensors, charging) sees 0, and the touchscreen does not start;
  - esoc, for the SDX50M (`arch/arm64/configs/vendor/guacamoleg.config`).

## Building
1. A lineage-24.0 tree with `manifest/guacamoleg.xml` in `.repo/local_manifests`, then `repo sync`.
2. This repo at `device/oneplus/guacamoleg`, then `device/oneplus/guacamoleg/patches/apply.sh <tree>`.
3. The firmware and the SDX50M's loader: `./extract-radio.sh <OTA zip> <tree>` with the OxygenOS 10.0.15 full OTA,
   `OnePlus7ProNROxygen_21.E.31_OTA_031_all_2111271509_64912a56fefe.zip` (MD5 `443079369e983608765e5627f14986bf`).
   It writes `vendor/oneplus/guacamoleg`; the files are OnePlus's and are not part of this repo.
4. `breakfast guacamoleg && m bacon`.

## Status
Tested on a GM1920 (EEA) over OxygenOS 10.0.15 firmware:
- works: boot, touch, display, 4G calls (VoLTE), SMS, mobile data, Wi-Fi, audio, camera, sensors (all 38 report);
- the SDX50M starts (firmware loaded, esoc0 up) and reports 5G, and Settings offers 5G; it has not yet connected to 5G
  where another phone on the same network does: next is the modem's view of 5G cells, with more logging;
- Bluetooth turns on, but pairing is untested;
- the fingerprint sensor's service starts without errors, but enrolling a finger is untested.

Installing over OxygenOS: flash the images from the zip's payload with fastboot (the boot, dtbo and vbmeta built
alongside it are not the ones in the zip), or flash its boot as the recovery and sideload the zip; then format data.
