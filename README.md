# OnePlus 7 Pro 5G (guacamoleg)

LineageOS device tree for the OnePlus 7 Pro 5G (GM1920, `OnePlus7ProNR`), which LineageOS has never supported.

The 5G model is a OnePlus 7 Pro (`guacamole`, official on lineage-24.0) with a second modem: a Qualcomm SDX50M on
PCIe, for 5G. This tree builds on guacamole and changes only what differs:

- **Device name**: `guacamoleg`; the zip installs on `OnePlus7ProNR` and nothing else.
- **Firmware**: the 5G model's own, from its last OxygenOS (10.0.15, November 2021). The modem image carries the
  SDX50M's firmware (`image/sdx50m`); the OnePlus 7 Pro's firmware is for a different modem and is never used.
- **The SDX50M**: `init.guacamoleg.rc` starts `vendor.mdm_helper`, which loads its firmware and restarts it after a crash
  (sm8150-common ships the helper but nothing starts it). The kernel already has the SDX50M's drivers and device tree.
- **5G radio settings** from OxygenOS 10.0.15 (`vendor.prop`).

## Building
1. A lineage-24.0 tree with `manifest/guacamoleg.xml` in `.repo/local_manifests`, then `repo sync`.
2. This repo at `device/oneplus/guacamoleg`.
3. The firmware: `./extract-radio.sh <OTA zip> <tree>` with the OxygenOS 10.0.15 full OTA,
   `OnePlus7ProNROxygen_21.E.31_OTA_031_all_2111271509_64912a56fefe.zip` (MD5 `443079369e983608765e5627f14986bf`).
   It writes `vendor/oneplus/guacamoleg`; the firmware is OnePlus's and is not part of this repo.
4. `breakfast guacamoleg && m bacon`.

## Status
Builds are untested on the phone. Open questions: OxygenOS 10 firmware under blobs from OxygenOS 11 for the OnePlus 7 Pro
(keymaster, audio, sensors, camera), and the SDX50M's 5G data path.
