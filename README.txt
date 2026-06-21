===============================================================================
  📑 PANDUAN UTAMA OPERASIONAL SAWANG-JUMPBOX (PORTABLE VERSION)
===============================================================================

File ini adalah panduan manual resmi untuk konfigurasi shortcut, manajemen 
database server, serta pembuatan kunci password terenkripsi GPG dengan sistem 
Auto-Passphrase (tanpa prompt).

-------------------------------------------------------------------------------
[A] STRUKTUR FOLDER KELOMPOK (100% PORTABLE)
-------------------------------------------------------------------------------
~/sawang-jumpbox/
├── ssh-server.sh        <- Script utama pencari server & auto-login
├── newpass.sh           <- Script menu interaktif (Tambah/Hapus Kunci GPG)
├── list-server.txt      <- Database IP, User, dan Port server target
├── README.txt           <- Panduan manual (File yang sedang kamu baca ini)
└── pass/                <- Folder khusus tempat menampung password pool (.gpg)

*Catatan: Satu folder ini bisa langsung di-zip/dipindah ke Servermu
          tanpa perlu mengubah isi kodingan di dalamnya.

-------------------------------------------------------------------------------
[B] SPESIFIKASI MINIMAL OS & LINGKUNGAN KERJA
-------------------------------------------------------------------------------
Agar seluruh script ini dapat berjalan dengan sempurna, pastikan lingkungan 
sistem memenuhi syarat berikut:

- Linux murni (Semua distro modern berbasis Ubuntu, Debian, CentOS, RHEL, 
  Rocky Linux, AlmaLinux, Oracle Linux, dll).
- Windows dengan Emulator Lingkungan Linux (MobaXterm, Cygwin, atau Git Bash).
- Android (Menggunakan aplikasi Termux).

-------------------------------------------------------------------------------
[C] PANDUAN CEK PAKET CORE & CARA INSTALASI
-------------------------------------------------------------------------------
Sebelum menjalankan script, pastikan 4 aplikasi core ini sudah terinstall di 
sistem. Kamu bisa mengecek ketersediaannya dengan perintah berikut:

$ which bash ssh gpg sshpass

JIKA ADA PAKET YANG TIDAK TERSEDIA (Command Not Found), SILAKAN INSTALL DULU:

1. Di Ubuntu / Debian / Servermu:
   $ sudo apt update && sudo apt install bash openssh-client gnupg2 sshpass -y

2. Di CentOS / RHEL / Rocky Linux / Oracle Linux:
   $ sudo yum install epel-release -y && sudo yum install bash openssh-clients gnupg2 sshpass -y

3. Di Emulator MobaXterm (Windows):
   $ apt install gnupg sshpass

4. Di Android (Termux):
   $ pkg install openssh gnupg sshpass -y

-------------------------------------------------------------------------------
[D] CARA SETUP SHORTCUT TERMINAL (Cukup 1 Kali di Setiap User Baru)
-------------------------------------------------------------------------------
Agar kamu bisa langsung mengetik perintah pendek 'akses' di terminal:

1. Buka file konfigurasi terminal kamu:
   $ nano ~/.bashrc

2. Tempelkan/paste kode fungsi ini di baris paling bawah file:

akses() {
    local SCRIPT_PATH=$(find $HOME -name "ssh-server.sh" -print -quit 2>/dev/null)
    if [ -z "$SCRIPT_PATH" ]; then
        echo "Error: File ssh-server.sh tidak ditemukan di dalam $HOME!"
        return 1
    fi
    "$SCRIPT_PATH" "$1"
}

3. Simpan (Ctrl+O, Enter, Ctrl+X), lalu jalankan perintah reload:
   $ source ~/.bashrc

Penggunaan: $ akses [nama_alias_server] (Contoh: akses app132)

-------------------------------------------------------------------------------
[E] CARA PENGISIAN DATABASE SERVER (list-server.txt)
-------------------------------------------------------------------------------
Gunakan format pemisah koma (,) tanpa spasi untuk mendaftarkan server baru.
Format penulisan: ALIAS,USER@IP_ADDRESS,PORT

Contoh Isi File:
app132,sawang@192.168.58.132,22
app10,root@192.168.1.10,2323

-------------------------------------------------------------------------------
[F] CARA MENGGUNAKAN MENU MANAGEMENT PASSWORD (newpass.sh)
-------------------------------------------------------------------------------
Untuk menambah atau menghapus kunci .gpg, jalankan script ini di dalam folder:
   $ ./newpass.sh

-------------------------------------------------------------------------------
[G] DISCLAIMER & MEKANISME KEAMANAN
-------------------------------------------------------------------------------
1. Script menggunakan mekanisme bypass passphrase internal bawaan (123).
2. DISCLAIMER: Seluruh enkripsi GPG bergantung pada keamanan passphrase yang 
   ditanam di dalam script. Pastikan file script utama tidak dapat dibaca oleh 
   pihak tidak berwenang (atur permission file menggunakan 'chmod 700').
3. Kebocoran kredensial akibat kelalaian manajemen hak akses server lokal pada 
   Servermu berada di luar tanggung jawab pengembang.

===============================================================================
* Powered by Sawang | Official Web: https://sawang.my.id
===============================================================================
