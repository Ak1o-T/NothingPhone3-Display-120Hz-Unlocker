# Nothing Phone (3) — 120Hz & LTPO Unlocker (KernelSU / Magisk / APatch)

> [!WARNING]
> **COMPATIBILITY WARNING / ВАЖНОЕ ПРЕДУПРЕЖДЕНИЕ О СОВМЕСТИМОСТИ**
>
> 🇬🇧 **This module is designed EXCLUSIVELY FOR NOTHING PHONE (3) (model `A024`, codename `Metroid`).**  
> DO NOT INSTALL on Nothing Phone (1), Phone (2), Phone (2a), CMF Phone, or devices from other manufacturers (Xiaomi, Samsung, Pixel, etc.). The internal database payload is encrypted using hardware-specific AES-128-ECB keys and display timings calibrated strictly for Nothing Phone (3).
>
> 🇷🇺 **Этот модуль разработан ИСКЛЮЧИТЕЛЬНО ДЛЯ NOTHING PHONE (3) (модель `A024`, кодовое имя `Metroid`).**  
> НЕ УСТАНАВЛИВАЙТЕ его на Nothing Phone (1), Phone (2), Phone (2a), CMF Phone или устройства других брендов (Xiaomi, Samsung, Pixel и др.). Конфигурация базы данных зашифрована аппаратным ключом AES-128-ECB и использует профили дисплея, специфичные только для Nothing Phone (3).

---

## 🇬🇧 English Description

### What does this module do?
In **Nothing OS**, there is a built-in refresh rate restriction for various popular applications:
* **Twitch** is hardcoded to force the display into **60 Hz** whenever a video stream plays.
* **Telegram, Chrome, TikTok, Yandex Maps, and several browsers** are restricted to 60 or 90 Hz in the default dynamic profile.
* Newly installed and unlisted applications often fall back to 90 Hz instead of full 120 Hz.

This module lifts all artificial limits, allowing the entire system UI and all apps to run at a full **120 Hz**, while **completely preserving native LTPO variable refresh rate (1–120 Hz)**.

---

### Key Features:
1. **Uncapped 120 Hz Across All Apps:**
   * Twitch video player and chat run smoothly at 120 FPS without mode dropping.
   * Browsers (Chrome, Brave, Firefox, Opera), Telegram, TikTok, and navigation apps operate at full 120 Hz.
   * **Future Apps Support:** Any new application installed from Google Play or sideloaded APK automatically runs at 120 Hz out-of-the-box.
2. **Full Adaptive LTPO Preservation (1–120 Hz):**
   * Does **NOT** force static 120 Hz globally; panel power saving remains fully functional.
   * While interacting or scrolling: **120 Hz**.
   * While the screen is static/idle: panel refresh rate drops down to **1–2 Hz** (hardware verified via DRM CRTC driver `measured_fps: 1.8 FPS`), saving battery.
3. **Anti-Cheat Safe (Genshin Impact / Zenless Zone Zero):**
   * Sensitive titles with strict anti-cheat systems (*Genshin Impact*, *Zenless Zone Zero*) are **completely untouched** (zero entries, zero hooks), avoiding any ban risk.
4. **Cloud-Sync Override Protection (OnlineConfig Protection):**
   * Nothing OS includes a cloud daemon (`com.nothing.proxy`) that periodically overwrites local display configs with server defaults.
   * This module injects an SQLite trigger (`nt_lock_refresh_rate`) into the configuration database to prevent cloud updates from reverting your 120 Hz settings.
5. **Systemless & Non-Destructive:**
   * Does not modify `/system` or `/vendor` partitions physically (uses memory bind-mounts).
   * Fully compatible alongside performance and thermal modules (such as *Nothing Thermal & Gaming Optimizer*).

---

### Installation:
1. Download `NothingDisplayOptimizer-v1.0.zip` from the [Releases](https://github.com/Ak1o-T/NothingPhone3-Display-120Hz-Unlocker/releases) section.
2. Open **KernelSU**, **APatch**, or **Magisk**.
3. Navigate to **Modules** -> **Install from storage** and select the `.zip`.
4. Reboot your device.
5. Unlock your device with your PIN/fingerprint after boot — the module activates automatically.

---

## 🇷🇺 Описание на русском

### Что делает этот модуль?
В фирменной оболочке **Nothing OS** существует скрытое искусственное ограничение частоты обновления экрана для ряда популярных приложений:
* **Twitch** заблокирован на **60 Гц** (при воспроизведении любого стрима экран принудительно переключается в режим 60 Гц).
* **Telegram, Chrome, TikTok, Яндекс.Карты и сторонние браузеры** искусственно ограничены до 60 или 90 Гц в профиле по умолчанию.
* Приложения, установленные в будущем, по умолчанию могут ограничиваться профилем «Динамическая» (90 Гц).

Этот модуль полностью снимает эти ограничения, заставляя весь интерфейс и все приложения работать на **120 Гц**, при этом **полностью сохраняя работу динамического LTPO (1–120 Гц)**.

---

### Ключевые возможности:
1. **Принудительные 120 Гц во всех приложениях:**
   * Twitch воспроизводит стримы и скроллит чат в плавных 120 FPS.
   * Браузеры (Chrome, Brave, Firefox, Opera), Telegram, TikTok и навигаторы работают в 120 Гц.
   * **Будущие приложения:** Любые новые приложения, которые вы установите из Google Play или APK, автоматически работают на максимальных 120 Гц.
2. **Полное сохранение работы LTPO (1–120 Гц):**
   * Модуль **НЕ отключает** энергосбережение панели.
   * Когда вы листаете ленту или касаетесь экрана — частота мгновенно поднимается до **120 Гц**.
   * Как только экран статичен (палец убран) — частота панели на аппаратном уровне падает до **1–2 Гц** (проверено аппаратно через DRM-контроллер: `1.8 FPS`), сберегая заряд батареи.
3. **Безопасность в играх (Genshin Impact / Zenless Zone Zero):**
   * Тяжёлые игры с античитами (*Genshin Impact*, *Zenless Zone Zero*) **вообще не затронуты** (0 хуков, 0 изменений в конфигах), исключая любой риск бана аккаунтов.
4. **Защита от сброса облаком (OnlineConfig Protection):**
   * В Nothing OS встроен облачный демон `com.nothing.proxy`, регулярно перезаписывающий локальные настройки герцовки своими файлами.
   * Модуль содержит SQLite-триггер `nt_lock_refresh_rate`, блокирующий любые попытки перезаписи конфигурации частоты обновления.
5. **Полная совместимость:**
   * Не конфликтует с модулями оптимизации производительности (например, *Nothing Thermal & Gaming Optimizer*).

---

### Установка:
1. Скачайте архив `NothingDisplayOptimizer-v1.0.zip` из раздела [Releases](https://github.com/Ak1o-T/NothingPhone3-Display-120Hz-Unlocker/releases).
2. Откройте **KernelSU**, **APatch** или **Magisk**.
3. Перейдите во вкладку **Модули** -> **Установить из хранилища** и выберите скачанный `.zip`.
4. Перезагрузите устройство.
5. После перезагрузки разблокируйте экран (введите PIN) — модуль активируется автоматически.

---

### Author & Credits
* Developed for **Nothing Phone (3)** (`Metroid` / `A024`).
* Architecture: KernelSU systemless overlay & SQLite OnlineConfig payload injection.
