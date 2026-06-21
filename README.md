# Sawang Jumpbox Automation (Portable Version)

Sebuah perangkat otomasi mini jumpbox berbasis Bash Script yang didesain untuk mengelola banyak target server SSH secara portable.

Project ini mengombinasikan:

* GPG Key Ring (Password Pooling)
* Failover Authentication otomatis
* Robot penyuntik kredensial menggunakan `sshpass`
* Auto-Passphrase (0-click) tanpa perlu memasukkan PIN secara manual

---

## ¿ Struktur Repositori

```text
sawang-jumpbox/
¿¿¿ ssh-server.sh        # Script otomasi pencari server & auto-login
¿¿¿ newpass.sh           # Menu interaktif tambah/hapus kunci GPG
¿¿¿ list-server.txt      # Database IP, user, dan port server target
¿¿¿ README.md            # Dokumentasi utama
¿¿¿ pass/                # Vault password terenkripsi (.gpg)
```

---

## ¿ Persyaratan Sistem

### Sistem Operasi yang Didukung

* Ubuntu
* Debian
* CentOS
* RHEL
* Rocky Linux
* AlmaLinux
* Oracle Linux
* MobaXterm (Windows)
* Cygwin
* Git Bash
* Termux (Android)

### Dependensi

Pastikan aplikasi berikut tersedia:

```bash
which bash ssh gpg sshpass
```

---

## ¿ Instalasi Dependensi

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install bash openssh-client gnupg2 sshpass -y
```

### RHEL / CentOS / Rocky / Oracle Linux

```bash
sudo yum install epel-release -y
sudo yum install bash openssh-clients gnupg2 sshpass -y
```

### MobaXterm

```bash
apt install gnupg sshpass
```

### Android (Termux)

```bash
pkg install openssh gnupg sshpass -y
```

---

# ¿ Instalasi

## 1. Clone Repository

```bash
git clone https://github.com/sawangmyid/sawang-jumpbox.git
cd sawang-jumpbox

chmod +x ssh-server.sh
chmod +x newpass.sh
```

---

## 2. Setup Shortcut Terminal

Edit file `.bashrc`:

```bash
nano ~/.bashrc
```

Tambahkan fungsi berikut di bagian paling bawah:

```bash
akses() {
    local SCRIPT_PATH=$(find "$HOME" -name "ssh-server.sh" -print -quit 2>/dev/null)

    if [ -z "$SCRIPT_PATH" ]; then
        echo "Error: File ssh-server.sh tidak ditemukan di dalam $HOME!"
        return 1
    fi

    "$SCRIPT_PATH" "$1"
}
```

Muat ulang konfigurasi shell:

```bash
source ~/.bashrc
```

---

## 3. Konfigurasi Database Server

Edit file `list-server.txt`.

Format:

```text
ALIAS,USER@IP_ADDRESS,PORT
```

Contoh:

```text
app132,sawang@192.168.58.132,22
web001,root@10.10.10.10,2222
db001,admin@172.16.1.100,22
```

---

## 4. Manajemen Password Vault

Jalankan:

```bash
./newpass.sh
```

Menu ini digunakan untuk:

* Menambahkan password ke vault GPG
* Menghapus password dari vault GPG
* Mengelola password pool yang digunakan saat login otomatis

---

## 5. Login ke Server

Contoh penggunaan:

```bash
akses app132
```

Script akan:

1. Mencari alias pada `list-server.txt`
2. Mengambil password dari password pool
3. Melakukan autentikasi otomatis menggunakan `sshpass`
4. Membuka sesi SSH ke server tujuan

---

# ¿ Keamanan

## Auto-Passphrase Mechanism

Vault GPG menggunakan mekanisme auto-passphrase sehingga proses enkripsi dan dekripsi dapat berjalan tanpa interaksi pengguna.

## Rekomendasi Hak Akses

Batasi akses file script utama:

```bash
chmod 700 ssh-server.sh
chmod 700 newpass.sh
```

Batasi juga akses direktori password:

```bash
chmod 700 pass
```

---

# ¿¿ Disclaimer

Project ini disediakan **"AS IS"** tanpa jaminan apa pun.

Pengguna bertanggung jawab penuh atas:

* Keamanan server lokal
* Pengelolaan hak akses file
* Penyimpanan kredensial
* Risiko kebocoran data akibat kesalahan konfigurasi

Gunakan dengan bijak dan sesuai kebijakan keamanan organisasi masing-masing.

---

# ¿¿¿ Pengembang

**Sawang**

Website:

https://sawang.my.id

---

# ¿ Lisensi

Distributed under the MIT License.

See `LICENSE` for more information.

