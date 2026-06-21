# 📑 Sawang Jumpbox Automation (Portable Version)

[![Bash Script](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Security: GPG](https://img.shields.io/badge/Security-GPG--Encrypted-blue)](https://gnupg.org/)

Sebuah perangkat otomasi *mini jumpbox* berbasis Bash Script yang didesain khusus untuk mengelola puluhan target server SSH secara portable. Project ini mengombinasikan **GPG Key Ring (Password Pooling)** untuk fitur *failover-auth* otomatis, robot penyuntik kredensial **`sshpass`**, dan mekanisme **Auto-Passphrase (0-click)** tanpa interupsi ketik PIN manual.

---

## 📂 Struktur Repositori

```text
sawang-jumpbox/
├── ssh-server.sh        # Script otomasi pencari server & auto-login
├── newpass.sh           # Script menu interaktif (Tambah/Hapus Kunci GPG)
├── list-server.txt      # Database IP, User, dan Port server target
├── README.md            # Dokumentasi utama GitHub (File ini)
└── pass/                # Vault tempat menampung password pool terenkripsi (.gpg)


🛠��� Persyaratan Sistem & Dependensi
1. Sistem Operasi / Environment Teruji:

    Linux Environment: Ubuntu, Debian, CentOS, RHEL, Rocky Linux, AlmaLinux, Oracle Linux.

    Windows Terminal Emulators: MobaXterm, Cygwin, atau Git Bash.

    Android: Termux App.

2. Aplikasi Core yang Dibutuhkan:

Pastikan paket berikut tersedia dengan mengecek perintah $ which bash ssh gpg sshpass. Jika belum ada, lakukan instalasi sesuai platform:

    Ubuntu / Debian / Servermu:

Bash

  sudo apt update && sudo apt install bash openssh-client gnupg2 sshpass -y

    RHEL / CentOS / Rocky / Oracle Linux:

Bash

  sudo yum install epel-release -y && sudo yum install bash openssh-clients gnupg2 sshpass -y

    MobaXterm (Windows):

Bash

  apt install gnupg sshpass

    Android (Termux):

Bash

  pkg install openssh gnupg sshpass -y

🚀 Panduan Instalasi & Penggunaan
Langkah 1: Clone Repositori
Bash

git clone [https://github.com/username-kamu/sawang-jumpbox.git](https://github.com/username-kamu/sawang-jumpbox.git)
cd sawang-jumpbox
chmod +x ssh-server.sh newpass.sh

Langkah 2: Setup Shortcut Terminal (akses)

    Buka file .bashrc:

Bash

   nano ~/.bashrc

    Tempelkan baris kode berikut di posisi paling bawah:

Bash

   akses() {
       local SCRIPT_PATH=$(find $HOME -name "ssh-server.sh" -print -quit 2>/dev/null)
       if [ -z "$SCRIPT_PATH" ]; then
           echo "Error: File ssh-server.sh tidak ditemukan di dalam $HOME!"
           return 1
       fi
       "$SCRIPT_PATH" "$1"
   }

    Muat ulang konfigurasi terminal:

Bash

   source ~/.bashrc

Langkah 3: Konfigurasi Database Server (list-server.txt)

Edit file menggunakan pemisah koma (,) dengan format: ALIAS,USER@IP_ADDRESS,PORT.
Plaintext

app132,sawang@192.168.58.132,22

Langkah 4: Manajemen Password Vault (newpass.sh)
Bash

./newpass.sh

Langkah 5: Eksekusi Remote Login
Bash

akses app132

🔒 Mekanisme Keamanan & Disclaimer

    Auto-Passphrase Mechanism: Enkripsi dan dekripsi otomatis memanfaatkan static security token (123) yang ditanam langsung secara asimetris pada kode inti script.

    Revisi Hak Akses: Sangat direkomendasikan untuk membatasi hak akses membaca berkas skrip utama menggunakan perintah chmod 700 ssh-server.sh.

    DISCLAIMER: Project ini disediakan "sebagaimana adanya" (AS IS) tanpa jaminan apa pun. Penyalahgunaan kode, kebocoran kredensial akibat kelalaian manajemen hak akses server lokal sepenuhnya merupakan tanggung jawab pengguna secara mandiri.

👤 Pengembang

    Sawang - Core Developer - sawang.my.id

Distributed under the MIT License. See LICENSE for more information.
