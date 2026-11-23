#!/system/bin/sh
MODDIR="${0%/*}"
[ -z "$MODDIR" ] && MODDIR="/data/adb/modules/nt_display_refresh"

# 1. Bind mount vendor display refresh rate config
TARGET="/vendor/etc/display_refresh_rate_config.json"
SOURCE="$MODDIR/display_refresh_rate_config.json"

if [ -f "$SOURCE" ] && [ -f "$TARGET" ]; then
    mount | grep -q "$TARGET" || mount -o bind "$SOURCE" "$TARGET"
fi

# 2. Ensure NtOnlineConfig is deployed
DB_TARGET="/data/user_de/0/com.nothing.proxy/databases/NtOnlineConfig"
DB_SOURCE="$MODDIR/NtOnlineConfig"

if [ -f "$DB_SOURCE" ] && [ -d "/data/user_de/0/com.nothing.proxy/databases" ]; then
    chattr -i "$DB_TARGET" 2>/dev/null
    if [ ! -f "$DB_TARGET" ]; then
        cp -f "$DB_SOURCE" "$DB_TARGET"
        chown system:system "$DB_TARGET"
        chmod 660 "$DB_TARGET"
        rm -f "${DB_TARGET}-journal" "${DB_TARGET}-wal" "${DB_TARGET}-shm"
    fi
fi
