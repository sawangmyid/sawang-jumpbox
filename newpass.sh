#!/bin/bash
# ===============================================================================
# Name        : newpass.sh (Management Tool for sawang-jumpbox)
# Developer   : Sawang | https://sawang.my.id
# ===============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GPG_DIR="$SCRIPT_DIR/pass"
PASSPHRASE_GPG="123"

clear
echo "======================================================="
echo "       üîë SAWANG-JUMPBOX PASSWORD MANAGER üîë"
echo "======================================================="
echo " 1. Tambah / Update Kunci Password Baru"
echo " 2. Hapus Kunci Password Lama"
echo " 3. Keluar"
echo "======================================================="
read -p "Pilih opsi (1-3): " OPSI

case $OPSI in
    1)
        echo ""
        echo "--- [1] TAMBAH / UPDATE KUNCI PASSWORD ---"
        read -p "Masukkan nama file kunci (ex: kunci_baru): " NAMA_KUNCI
        read -s -p "Masukkan password asli server: " PASSWORD_ASLI
        echo ""

        if [ -z "$NAMA_KUNCI" ] || [ -z "$PASSWORD_ASLI" ]; then
            echo "‚ùå Error: Nama kunci dan password tidak boleh kosong!"
            exit 1
        fi

        [[ ! "$NAMA_KUNCI" == *.gpg ]] && NAMA_KUNCI="${NAMA_KUNCI}.gpg"
        FILE_TARGET="$GPG_DIR/$NAMA_KUNCI"

        echo "üîí Sedang mengunci password ke format GPG..."
        echo "$PASSWORD_ASLI" | gpg --batch --yes --passphrase "$PASSPHRASE_GPG" -c -o "$FILE_TARGET"
        
        if [ $? -eq 0 ]; then
            echo "======================================================="
            echo "‚úÖ SUKSES: File password berhasil disimpan!"
            echo "üìÇ Lokasi: pass/$NAMA_KUNCI"
            echo "======================================================="
        else
            echo "‚ùå GAGAL: Terjadi kesalahan enkripsi GPG."
        fi
        ;;

    2)
        echo ""
        echo "--- [2] HAPUS KUNCI PASSWORD LAMA ---"
        if [ ! -d "$GPG_DIR" ] || [ -z "$(ls -A "$GPG_DIR" 2>/dev/null)" ]; then
            echo "‚Ñπˆ∏è Folder pass/ masih kosong. Tidak ada kunci yang bisa dihapus."
            exit 0
        fi

        echo "Daftar kunci saat ini:"
        echo "-------------------------------------------------------"
        ls -1 "$GPG_DIR" | grep "\.gpg$" | sed 's/^/ - /'
        echo "-------------------------------------------------------"
        read -p "Ketik nama file yang ingin dihapus: " HAPUS_KUNCI

        [[ ! "$HAPUS_KUNCI" == *.gpg ]] && HAPUS_KUNCI="${HAPUS_KUNCI}.gpg"
        FILE_HAPUS="$GPG_DIR/$HAPUS_KUNCI"

        if [ -f "$FILE_HAPUS" ]; then
            rm "$FILE_HAPUS"
            echo "======================================================="
            echo "üóëˆ∏è SUCCESS: File $HAPUS_KUNCI telah dihapus dari folder pass/."
            echo "======================================================="
        else
            echo "‚ùå Error: File '$HAPUS_KUNCI' tidak ditemukan!"
        fi
        ;;

    3)
        echo "Keluar dari menu."
        exit 0
        ;;
    *)
        echo "‚ùå Opsi tidak valid!"
        exit 1
        ;;
esac
