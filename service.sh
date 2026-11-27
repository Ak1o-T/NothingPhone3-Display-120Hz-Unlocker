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

# --- Smooth UI 120Hz & Blur Optimization ---
# Give UI/Render threads immediate scheduler headroom (prevents 120Hz frame drops on touch)
echo 15 > /dev/cpuctl/top-app/cpu.uclamp.min 2>/dev/null
echo 10 > /dev/cpuctl/foreground_window/cpu.uclamp.min 2>/dev/null
echo 10 > /dev/cpuctl/nt_foreground/cpu.uclamp.min 2>/dev/null
echo 5  > /dev/cpuctl/foreground/cpu.uclamp.min 2>/dev/null

# Ensure client composition cache stays enabled
setprop debug.sf.disable_client_composition_cache 0 2>/dev/null

# --- Memory, ZRAM & UFS I/O Tuning ---
echo 60 > /proc/sys/vm/swappiness 2>/dev/null
for q in /sys/block/sd*/queue/read_ahead_kb; do
    [ -f "$q" ] && echo 256 > "$q" 2>/dev/null
done
if [ -f /sys/block/zram0/comp_algorithm ] && ! grep -q '\[lz4\]' /sys/block/zram0/comp_algorithm 2>/dev/null; then
    zram_size=$(cat /sys/block/zram0/disksize 2>/dev/null)
    [ -z "$zram_size" ] && zram_size=9663676416
    if swapoff /dev/block/zram0 2>/dev/null; then
        echo 1 > /sys/block/zram0/reset 2>/dev/null
        echo lz4 > /sys/block/zram0/comp_algorithm 2>/dev/null
        echo "$zram_size" > /sys/block/zram0/disksize 2>/dev/null
        mkswap /dev/block/zram0 >/dev/null 2>&1
        swapon /dev/block/zram0 2>/dev/null
    fi
fi

# Keep snappy 0.85 animation scales (never 0, so NothingBlurIcons/Shortcuts ValueAnimators stay smooth)
settings put global window_animation_scale 0.85 2>/dev/null
settings put global transition_animation_scale 0.85 2>/dev/null
settings put global animator_duration_scale 0.85 2>/dev/null

# Ensure AOT 'speed' compilation for core UI and NothingBlur modules (auto-recovers after OTA/updates)
(
    sleep 15
    for pkg in com.nothing.launcher com.android.systemui com.nothing.bluricons com.nothing.blurshortcuts; do
        if pm path "$pkg" >/dev/null 2>&1; then
            if ! dumpsys package "$pkg" 2>/dev/null | grep -m1 "status=" | grep -q "status=speed\]"; then
                cmd package compile -m speed -f "$pkg" >/dev/null 2>&1
            fi
        fi
    done
) &
