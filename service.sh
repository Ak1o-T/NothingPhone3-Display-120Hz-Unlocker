#!/system/bin/sh
MODDIR="${0%/*}"
[ -z "$MODDIR" ] && MODDIR="/data/adb/modules/nt_display_refresh"

TARGET="/vendor/etc/display_refresh_rate_config.json"
SOURCE="$MODDIR/display_refresh_rate_config.json"

if [ -f "$SOURCE" ] && [ -f "$TARGET" ]; then
    mount | grep -q "$TARGET" || mount -o bind "$SOURCE" "$TARGET"
fi

# Wait for boot completion
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

# Ensure database is present and properly owned
DB_TARGET="/data/user_de/0/com.nothing.proxy/databases/NtOnlineConfig"
DB_SOURCE="$MODDIR/NtOnlineConfig"

if [ -f "$DB_SOURCE" ] && [ -d "/data/user_de/0/com.nothing.proxy/databases" ]; then
    # Ensure no +i lock (which broke SQLite opening)
    chattr -i "$DB_TARGET" 2>/dev/null
    # Copy if missing
    if [ ! -f "$DB_TARGET" ]; then
        cp -f "$DB_SOURCE" "$DB_TARGET"
        chown system:system "$DB_TARGET"
        chmod 660 "$DB_TARGET"
        rm -f "${DB_TARGET}-journal" "${DB_TARGET}-wal" "${DB_TARGET}-shm"
    fi
fi

# Enforce High (120Hz) refresh mode in Nothing OS
settings put global display_refresh_rate_mode 1 2>/dev/null
settings put system display_refresh_rate_mode 1 2>/dev/null
settings put system peak_refresh_rate 120.0 2>/dev/null
settings put system min_refresh_rate 120.0 2>/dev/null

# Clear display high refresh rate blacklist
device_config put display high_refresh_rate_blacklist "" 2>/dev/null
