#!/bin/bash
# ===============================================================================
# Name        : ssh-server.sh (Core Core of sawang-jumpbox)
# Description : Automated SSH Login via GPG Password Pooling & sshpass
# Developer   : Sawang | https://sawang.my.id
# ===============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIST_FILE="$SCRIPT_DIR/list-server.txt"
GPG_DIR="$SCRIPT_DIR/pass"
ALIAS_INPUT="$1"
PASSPHRASE_GPG="123"

if [ -z "$ALIAS_INPUT" ]; then
    echo "======================================================="
    echo "Format Salah! Gunakan: konek [nama_server]"
    echo "======================================================="
    [ -f "$LIST_FILE" ] && awk -F',' '{print " - " $1 " (" $2 " Port " $3 ")"}' "$LIST_FILE"
    exit 1
fi

if [ ! -f "$LIST_FILE" ]; then
    echo "Error: File database list-server.txt tidak ditemukan!"
    exit 1
fi

MATCHING_LINE=$(grep -E "^${ALIAS_INPUT}," "$LIST_FILE")
if [ -z "$MATCHING_LINE" ]; then
    echo "Error: Server '$ALIAS_INPUT' tidak terdaftar!"
    exit 1
fi

TARGET=$(echo "$MATCHING_LINE" | cut -d',' -f2)
PORT=$(echo "$MATCHING_LINE" | cut -d',' -f3)

if [ ! -d "$GPG_DIR" ]; then
    echo "Error: Folder '$GPG_DIR' tidak ditemukan!"
    exit 1
fi

GPG_FILES=("$GPG_DIR"/*.gpg)
if [ ! -e "${GPG_FILES[0]}" ]; then
    echo "Error: Tidak ditemukan file .gpg di dalam folder: $GPG_DIR"
    exit 1
fi

mkdir -p ~/.gnupg
if ! grep -q "allow-preset-passphrase" ~/.gnupg/gpg-agent.conf 2>/dev/null; then
    echo "allow-preset-passphrase" >> ~/.gnupg/gpg-agent.conf
    gpgconf --kill gpg-agent
fi

echo "======================================================="
echo " Melakukan Scanning Kunci Password di Folder: /pass"
echo " Target: $ALIAS_INPUT ($TARGET) Port $PORT"
echo "======================================================="

SUKSES_LOGIN=false

for FILE_GPG in "${GPG_FILES[@]}"; do
    NAMA_FILE=$(basename "$FILE_GPG")
    echo "üîë Menguji file: $NAMA_FILE"
    
    KEY_GRIP=$(gpg --with-colons --import-options show-only --import "$FILE_GPG" 2>/dev/null | awk -F: '/grp/ {print $10; exit}')
    if [ -n "$KEY_GRIP" ] && [ -x "/usr/lib/gnupg/gpg-preset-passphrase" ]; then
        /usr/lib/gnupg/gpg-preset-passphrase --preset --timeout 31536000 "$KEY_GRIP" <<< "$PASSPHRASE_GPG" 2>/dev/null
    fi

    PASSWORD=$(gpg --batch --yes --passphrase "$PASSPHRASE_GPG" -d -q "$FILE_GPG" 2>/dev/null)
    if [ -z "$PASSWORD" ]; then
        echo "   [!] Gagal dekripsi $NAMA_FILE (Passphrase salah/skip)."
        echo "-------------------------------------------------------"
        continue
    fi

    echo "   ‚öôˆ∏è  Mencoba login otomatis via sshpass..."
    sshpass -p "$PASSWORD" ssh -p "$PORT" -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$TARGET"
    STATUS_SSH=$?

    if [ $STATUS_SSH -eq 0 ]; then
        SUKSES_LOGIN=true
        break
    fi

    echo "   ‚ùå Password dari $NAMA_FILE DITOLAK oleh server."
    echo "-------------------------------------------------------"
done

if [ "$SUKSES_LOGIN" = false ]; then
    echo "======================================================="
    echo "‚ùå GAGAL: Semua file .gpg di folder /pass tidak ada yang cocok."
    echo "======================================================="
    exit 1
fi
