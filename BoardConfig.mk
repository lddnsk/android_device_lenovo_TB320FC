#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lenovo/TB320FC

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

include $(DEVICE_PATH)/device-version.mk

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    system_ext \
    product \
    vendor \
    vendor_boot \
    odm \
    recovery
BOARD_USES_RECOVERY_AS_BOOT := false

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a9

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := taro
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 400

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_RAMDISK_USE_LZ4 := true
# recovery.img of Y700 2023 doesn't contain a kernel. The kernel is extracted from boot.img.
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 104857600
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 12876513280
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm vendor_dlkm
#BOARD_LENOVO_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm
#BOARD_LENOVO_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := taro
TARGET_RECOVERY_QCOM_RTC_FIX := true

# AVB
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# Encryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
# Version number must be larger than system's version, Or FBE decryption should fail.
# e.g. When PLATFORM_VERSION is 14 and system's android version is 15, decryption will fail because of upgrade required error.
PLATFORM_VERSION := 99
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
PRODUCT_ENFORCE_VINTF_MANIFEST := true
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Recovery
TARGET_OTA_ASSERT_DEVICE := TB320FC
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2 \
	vendor.display.config@1.0 \
	vendor.display.config@2.0

# Hack: prevent anti rollback
#PLATFORM_SECURITY_PATCH := 2099-12-31
#VENDOR_SECURITY_PATCH := 2099-12-31

# Extras
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# TWRP Configuration
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
ifeq ($(USE_LANDSCAPE),true)
	RECOVERY_TOUCHSCREEN_FLIP_Y := true
	RECOVERY_TOUCHSCREEN_SWAP_XY := true
	TW_THEME := landscape_hdpi
	TW_ROTATION := 90
#	DEVICE_RESOLUTION := 2560x1600
else
	RECOVERY_TOUCHSCREEN_FLIP_Y := false
	RECOVERY_TOUCHSCREEN_SWAP_XY := false
	TW_THEME := portrait_hdpi
	TW_ROTATION := 0
#	DEVICE_RESOLUTION := 1600x2560
endif
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_USE_FSCRYPT_POLICY := 1
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FASTBOOTD := true
TW_EXCLUDE_APEX := true
#TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_NO_EXFAT_FUSE := true
TW_DEFAULT_BRIGHTNESS := 614
TW_HAS_EDL_MODE := true
TW_SKIP_ADDITIONAL_FSTAB := true

TW_NO_HAPTICS := true
#tests
#TW_LOAD_VENDOR_MODULES := "haptic.ko"
#TW_LOAD_VENDOR_MODULES += \
#	vendor.display.config@2.0
#TW_SUPPORT_INPUT_AIDL_HAPTICS ⏩ Установите "true", чтобы включить создание makefile для определенного оборудования.
#TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME ⏩ Введите правильный путь к данному оборудованию, и это позволит скомпилировать необходимые файлы. В данном случае это файлы для тактильных вибраторов.
#* В зависимости от типа оборудования опция может поддерживаться в режиме AIDL (hal format=" aidl ") или в режиме HIDL (hal format="hidl").
#Пример
#TW_SUPPORT_INPUT_1_2_HAPTICS := true

TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone41/temp

TW_MTP_DEVICE := /dev/usb-ffs/mtp
TW_EXCLUDE_TWRPAPP := true
#TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
#TW_FORCE_CPUINFO_FOR_DEVICE_ID := true

# TWRP Debug Flags
TARGET_USES_LOGD := true
TW_CRYPTO_SYSTEM_VOLD_DEBUG := true
TWRP_INCLUDE_LOGCAT := true
