#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Deploying Nothing Display 120Hz & LTPO Unlocker Module ==="

if ! command -v adb >/dev/null 2>&1; then
    echo "Error: adb command not found!"
    exit 1
fi

if ! adb get-state >/dev/null 2>&1; then
    echo "Error: No connected Android device found via adb!"
    exit 1
fi

echo "[1/4] Packaging flashable zip..."
mkdir -p /home/ak1o/Projects/Android/RootModules
cd "$DIR"
rm -f "$DIR/NothingDisplayOptimizer-v1.0.zip"
zip -r "$DIR/NothingDisplayOptimizer-v1.0.zip" module.prop post-fs-data.sh service.sh customize.sh display_refresh_rate_config.json NtOnlineConfig system vendor >/dev/null
cp -f "$DIR/NothingDisplayOptimizer-v1.0.zip" /home/ak1o/Projects/Android/RootModules/

echo "[2/4] Preparing target directory on device..."
adb shell "su -c 'mkdir -p /data/adb/modules/nt_display_refresh/vendor/etc /data/adb/modules/nt_display_refresh/system/vendor/etc'"

echo "[3/4] Pushing module files..."
adb push "$DIR/module.prop" /data/local/tmp/nt_disp_module.prop
adb push "$DIR/post-fs-data.sh" /data/local/tmp/nt_disp_post-fs-data.sh
adb push "$DIR/service.sh" /data/local/tmp/nt_disp_service.sh
adb push "$DIR/display_refresh_rate_config.json" /data/local/tmp/nt_disp_config.json
adb push "$DIR/NtOnlineConfig" /data/local/tmp/nt_disp_db

echo "[4/4] Installing and applying..."
adb shell "su -c '
mv -f /data/local/tmp/nt_disp_module.prop /data/adb/modules/nt_display_refresh/module.prop
mv -f /data/local/tmp/nt_disp_post-fs-data.sh /data/adb/modules/nt_display_refresh/post-fs-data.sh
mv -f /data/local/tmp/nt_disp_service.sh /data/adb/modules/nt_display_refresh/service.sh
mv -f /data/local/tmp/nt_disp_config.json /data/adb/modules/nt_display_refresh/display_refresh_rate_config.json
mv -f /data/local/tmp/nt_disp_db /data/adb/modules/nt_display_refresh/NtOnlineConfig
cp -f /data/adb/modules/nt_display_refresh/display_refresh_rate_config.json /data/adb/modules/nt_display_refresh/vendor/etc/display_refresh_rate_config.json
cp -f /data/adb/modules/nt_display_refresh/display_refresh_rate_config.json /data/adb/modules/nt_display_refresh/system/vendor/etc/display_refresh_rate_config.json

chmod 755 /data/adb/modules/nt_display_refresh/*.sh
chmod 644 /data/adb/modules/nt_display_refresh/module.prop
chmod 644 /data/adb/modules/nt_display_refresh/*.json
chmod 644 /data/adb/modules/nt_display_refresh/NtOnlineConfig
chmod 644 /data/adb/modules/nt_display_refresh/vendor/etc/*.json
chmod 644 /data/adb/modules/nt_display_refresh/system/vendor/etc/*.json

# Apply bind mount immediately
mount | grep -q \"/vendor/etc/display_refresh_rate_config.json\" || mount -o bind /data/adb/modules/nt_display_refresh/display_refresh_rate_config.json /vendor/etc/display_refresh_rate_config.json

# Deploy to com.nothing.proxy database
DB_TARGET=\"/data/user_de/0/com.nothing.proxy/databases/NtOnlineConfig\"
chattr -i \"\$DB_TARGET\" 2>/dev/null
[ -f \"\$DB_TARGET\" ] && [ ! -f \"\${DB_TARGET}.bak\" ] && cp -f \"\$DB_TARGET\" \"\${DB_TARGET}.bak\"
cp -f /data/adb/modules/nt_display_refresh/NtOnlineConfig \"\$DB_TARGET\"
chown system:system \"\$DB_TARGET\"
chmod 660 \"\$DB_TARGET\"
rm -f \"\${DB_TARGET}-journal\" \"\${DB_TARGET}-wal\" \"\${DB_TARGET}-shm\"
chattr +i \"\$DB_TARGET\" 2>/dev/null

# Enforce peak refresh rate
settings put system peak_refresh_rate 120.0
settings put system min_refresh_rate 120.0
device_config put display high_refresh_rate_blacklist \"\"
'"

echo "=== Nothing Display Unlocker deployed successfully! ==="
