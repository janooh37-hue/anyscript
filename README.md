# anyscript

A collection of personal utility scripts for Linux.

## Changelog

### 2026-03-22
- Added `requirements.txt` documenting system dependencies for all scripts

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
