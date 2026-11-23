SKIPUNZIP=0

# Ensure directories exist
mkdir -p "$MODPATH/vendor/etc"
mkdir -p "$MODPATH/system/vendor/etc"

cp -f "$MODPATH/display_refresh_rate_config.json" "$MODPATH/vendor/etc/display_refresh_rate_config.json"
cp -f "$MODPATH/display_refresh_rate_config.json" "$MODPATH/system/vendor/etc/display_refresh_rate_config.json"

# Deploy NtOnlineConfig
DB_TARGET="/data/user_de/0/com.nothing.proxy/databases/NtOnlineConfig"
if [ -f "$MODPATH/NtOnlineConfig" ] && [ -d "/data/user_de/0/com.nothing.proxy/databases" ]; then
    chattr -i "$DB_TARGET" 2>/dev/null
    [ -f "$DB_TARGET" ] && [ ! -f "${DB_TARGET}.bak" ] && cp -f "$DB_TARGET" "${DB_TARGET}.bak"
    cp -f "$MODPATH/NtOnlineConfig" "$DB_TARGET"
    chown system:system "$DB_TARGET"
    chmod 660 "$DB_TARGET"
    rm -f "${DB_TARGET}-journal" "${DB_TARGET}-wal" "${DB_TARGET}-shm"
    chattr +i "$DB_TARGET" 2>/dev/null
fi

set_perm "$MODPATH/post-fs-data.sh" 0 0 0755
set_perm "$MODPATH/service.sh" 0 0 0755
set_perm "$MODPATH/display_refresh_rate_config.json" 0 0 0644
set_perm "$MODPATH/NtOnlineConfig" 0 0 0644
