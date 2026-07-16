# anyscript

A collection of personal utility scripts for Linux.

## Changelog

### 2026-07-16
- Added `macro-calculator/` — a single-file web app (iOS 26 "Liquid Glass" aesthetic)
  that turns weight + height into daily fat-loss calories and a full macro breakdown

### 2026-03-22
- Added `requirements.txt` documenting system dependencies for all scripts

## Apps

### macro-calculator
A self-contained `index.html` (no build, no dependencies) that computes daily
fat-loss nutrition targets from just **weight** and **height**.

**Formula (per the source walkthrough, 100 kg example):**
1. Weight in kg × 2.2 → pounds (`100 → 220 lb`)
2. Pounds × 10 → total daily calories (`2,200 kcal`)
3. Protein = bodyweight(lb) × 0.8 → grams (`176 g`)
4. Fat = bodyweight(lb) × 0.3 → grams (`66 g`)
5. Fiber = calories ÷ 1,000 × 14 → grams (`31 g`)
6. Carbs = (calories − protein·4 − fat·9) ÷ 4 → grams (`≈226 g`)

**Beyond the formula (the "useful expansion"):**
- Macro calorie-distribution ring (protein / fat / carbs %)
- BMI, category, and a healthy-weight range for the entered height
- kg/lb and cm/ft-in unit toggles, live updating, light & dark mode

**Run it:** open `macro-calculator/index.html` in any browser
(or `npx http-server macro-calculator`).

## Scripts

### qbit-move.sh
Monitors qBittorrent for completed downloads and automatically moves them to a destination folder.

**Features:**
- Polls qBittorrent API every 30 seconds
- Copies completed torrents to destination directory
- Changes ownership to user after copy
- Removes source files after successful transfer
- Logs all operations

**Configuration:**
```bash
QBITTORRENT_URL="http://localhost:8080"
DEST_DIR="/home/amh/Downloads"
LOG_FILE="/home/amh/bin/qbit-move.log"
```

### yt-download
Interactive YouTube/video downloader using yt-dlp.

**Options:**
1. Best Video (1080p+)
2. Audio Only (MP3)
3. Best Quality (4K if available)

**Features:**
- Downloads to `/home/amh/Videos`
- Prevents duplicate downloads with archive
- Embeds thumbnails
- Adds metadata
- Desktop notifications on completion

### twitch
Twitch stream launcher with built-in ad-skip.

**Usage:**
```bash
./twitch <twitch_url>
# or paste URL (uses wl-paste)
```

**Features:**
- Uses streamlink with mpv
- Ad-skip via TTV.LOL proxy

## Requirements

- qbit-move.sh: curl, python3, qBittorrent running with API enabled
- yt-download: yt-dlp, ffmpeg, notify-send (optional)
- twitch: streamlink, mpv

## Installation

```bash
# Make scripts executable
chmod +x qbit-move.sh yt-download twitch

# Add to PATH or use directly
./qbit-move.sh
./yt-download
./twitch <url>
```
