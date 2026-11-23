# Nothing Phone (3) — 120Hz & LTPO Unlocker (KernelSU / Magisk / APatch)

> [!WARNING]
> **COMPATIBILITY NOTICE / ТОЛЬКО ДЛЯ NOTHING PHONE (3)**
> Этот модуль разработан **ИСКЛЮЧИТЕЛЬНО ДЛЯ NOTHING PHONE (3)** (модель `A024`, кодовое имя `Metroid`).  
> **НЕ УСТАНАВЛИВАЙТЕ** его на Nothing Phone (1), Phone (2), Phone (2a), CMF Phone или устройства других брендов (Xiaomi, Samsung, Pixel и др.). Конфигурация базы данных использует аппаратный ключ шифрования AES-128-ECB и параметры дисплея, специфичные только для Nothing Phone (3).
> 
> This module is designed **EXCLUSIVELY FOR NOTHING PHONE (3)** (`A024`, codename `Metroid`).  
> **DO NOT INSTALL** on Nothing Phone (1), (2), (2a), CMF Phone, or non-Nothing devices.

---

## 🇷🇺 Описание на русском

### Что делает этот модуль?
В фирменной оболочке **Nothing OS** существует скрытое искусственное ограничение частоты обновления экрана для ряда популярных приложений:
* **Twitch** заблокирован на **60 Гц** (при воспроизведении любого стрима частота экрана принудительно падает до 60 Гц).
* **Telegram, Chrome, TikTok, Яндекс.Карты, браузеры** искусственно ограничены до 60 или 90 Гц в профиле по умолчанию.
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

## 🇬🇧 English Description

### What does this module do?
In **Nothing OS**, there is a built-in refresh rate restriction for various popular applications:
* **Twitch** is hardcoded to lock the physical display mode to **60 Hz** whenever video playback starts.
* **Telegram, Chrome, TikTok, Maps, and several browsers** are restricted to 60 or 90 Hz in the dynamic mode.
* Unlisted / future installed apps often fall back to 90 Hz rather than full 120 Hz.

This module removes all refresh rate caps, allowing the entire UI and all apps to run at a full **120 Hz**, while **completely preserving native LTPO variable refresh rate (1–120 Hz)**.

---

### Features:
1. **Uncapped 120 Hz Across Apps:**
   * Twitch video player and chat run smoothly at 120 FPS.
   * Chrome, Telegram, social media, and navigation apps operate at full 120 Hz.
   * All future apps installed from the Play Store or sideloaded automatically adopt the 120 Hz mode.
2. **Adaptive LTPO Preservation:**
   * Dynamic refresh rate scaling remains fully active.
   * When interacting/scrolling: **120 Hz**.
   * When the screen is idle/static: panel scales down to **1–2 Hz** (hardware verified via DRM CRTC `measured_fps`), conserving battery.
3. **Anti-Cheat Safe:**
   * Strictly avoids touching or hooking sensitive titles (*Genshin Impact*, *Zenless Zone Zero*), ensuring zero ban risk.
4. **Cloud-Sync Override Protection:**
   * Nothing OS's `com.nothing.proxy` cloud synchronization is intercepted; SQLite triggers prevent OTA background tasks from overwriting the unlocked refresh rates.
5. **Modular & Safe:**
   * Does not modify `/system` or `/vendor` partitions physically (systemless bind-mount).

---

### Installation:
1. Download `NothingDisplayOptimizer-v1.0.zip` from [Releases](https://github.com/Ak1o-T/NothingPhone3-Display-120Hz-Unlocker/releases).
2. Open **KernelSU**, **APatch**, or **Magisk**.
3. Go to **Modules** -> **Install from storage** and select the `.zip`.
4. Reboot your phone and unlock with PIN.

---

### Author & Credits
* Developed for **Nothing Phone (3)** (`Metroid` / `A024`).
* Architecture: KernelSU systemless overlay & SQLite OnlineConfig payload injection.
