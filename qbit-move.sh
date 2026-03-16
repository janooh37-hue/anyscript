#!/bin/bash

QBITTORRENT_URL="http://localhost:8080"
DEST_DIR="/home/amh/Downloads"
LOG_FILE="/home/amh/bin/qbit-move.log"

log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

move_torrent() {
	local hash="$1"
	local name="$2"
	local root_path="$3"
	local dest_path="$DEST_DIR/$name"

	if [ -d "$root_path" ]; then
		log "Moving: $name from $root_path to $DEST_DIR/"
		cp -r "$root_path" "$dest_path" 2>&1 | tee -a "$LOG_FILE"
		if [ $? -eq 0 ]; then
			log "Successfully copied: $name"
			chown -R amh:amh "$dest_path" 2>&1 | tee -a "$LOG_FILE"
			rm -rf "$root_path" 2>&1 | tee -a "$LOG_FILE"
			if [ $? -eq 0 ]; then
				log "Successfully removed source: $name"
			else
				log "Failed to remove source: $name"
			fi
		else
			log "Failed to copy: $name"
		fi
	elif [ -f "$root_path.torrent" ]; then
		log "Moving torrent file: $name"
		mv "$root_path.torrent" "$DEST_DIR/" 2>&1 | tee -a "$LOG_FILE"
	else
		log "Content not found for: $name (path: $root_path)"
	fi
}

get_torrents() {
	curl -s "${QBITTORRENT_URL}/api/v2/torrents/info" 2>/dev/null
}

check_completed() {
	local torrents=$(get_torrents)

	if [ -z "$torrents" ] || [ "$torrents" = "[]" ]; then
		return
	fi

	echo "$torrents" | python3 -c "
import sys, json

try:
    data = json.load(sys.stdin)
    for t in data:
        state = t.get('state', '')
        progress = t.get('progress', 0)
        name = t.get('name', '')
        root_path = t.get('root_path', '')
        hash = t.get('hash', '')
        
        # Check if completed downloading and is now seeding/uploading
        if progress == 1.0 and 'UP' in state:
            print(f'{hash}|{name}|{root_path}')
except:
    pass
" 2>/dev/null
}

log "Starting qBittorrent monitor..."

while true; do
	while IFS='|' read -r hash name root_path; do
		if [ -n "$hash" ]; then
			move_torrent "$hash" "$name" "$root_path"
		fi
	done < <(check_completed)

	sleep 30
done
