# anyscript

A collection of personal utility scripts for Linux.

## Changelog

### 2026-07-16
- Added the **Macro Calculator** web app (`index.html` at repo root) — iOS 26
  "Liquid Glass" aesthetic, turns weight + height into daily fat-loss calories
  and a full macro breakdown. Installable to the iOS home screen (PWA) and
  works offline. Deployable for free via GitHub Pages.

### 2026-03-22
- Added `requirements.txt` documenting system dependencies for all scripts

## Apps

### Macro Calculator
A self-contained `index.html` (no build, no dependencies) at the repo root that
computes daily fat-loss nutrition targets from just **weight** and **height**.

**Formula (per the source walkthrough, 100 kg example):**
1. Weight in kg × 2.2 → pounds (`100 → 220 lb`)
2. Pounds × 10 → total daily calories (`2,200 kcal`)
3. Protein = bodyweight(lb) × 0.8 → grams (`176 g`)
4. Fat = bodyweight(lb) × 0.3 → grams (`66 g`)
5. Fiber = calories ÷ 1,000 × 14 → grams (`31 g`)
6. Carbs = (calories − protein·4 − fat·9) ÷ 4 → grams (`≈226 g`)

**Beyond the formula (the "useful expansion"):**
- A deliberate **Calculate My Plan** button (no auto-calc) drives the results.
- Macro calorie-distribution ring (protein / fat / carbs %)
- BMI, category, and a healthy-weight range for the entered height
- **Taste profile** — a short, indirect lifestyle quiz (never "do you like
  chicken?") infers a food archetype (The Carnivore, The Minimalist, The
  Plant-Forward…) and **re-sorts every food list to favor what you'd eat**,
  starring your top matches
- **Fuel Your Day** — real foods per macro, personalized + with how many
  portions of each it takes to hit *your* protein / carb / fat / fiber target
- **Hydration** — daily water target (~35 ml/kg) with a tap-to-log tracker
  (glass / bottle / large), progress ring, undo, and per-day persistence
- **Move to Burn It** — a fat-loss training strategy plus calories burned in
  30 min for 11 activities, scaled to your bodyweight (MET-based)
- **Keep Going** — curated links to trusted trackers & guides (Cronometer,
  USDA FoodData Central, Examine, NHS, CDC, r/fitness wiki)
- Your plan, taste profile, and water log **persist locally**, so the
  home-screen app remembers you between visits
- kg/lb and cm/ft-in unit toggles, light & dark mode

**Run it locally:** open `index.html` in any browser (or `npx http-server .`).

**Host it free on GitHub Pages:**
1. On GitHub, go to **Settings → Pages**.
2. Under **Source**, choose **Deploy from a branch**.
3. Pick the branch (`main` after merging, or `claude/ios-macro-calculator-a56nfe`)
   and folder **`/ (root)`**, then **Save**.
4. After ~1 minute it's live at
   `https://janooh37-hue.github.io/anyscript/`

**Add to iPhone home screen:** open that URL in **Safari** → tap the **Share**
button → **Add to Home Screen**. It installs as a full-screen app named
"Macros" with its own icon, and works offline (service worker + web manifest).

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
