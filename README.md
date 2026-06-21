# Sawang Jumpbox Automation (Portable Version)

Sebuah perangkat otomasi mini jumpbox berbasis Bash Script untuk mengelola banyak target server SSH secara portable.

Project ini mengombinasikan:

* GPG Key Ring (Password Pooling)
* Failover Authentication otomatis
* Integrasi `sshpass` untuk login otomatis
* Auto-Passphrase Mechanism
* Database server berbasis file teks sederhana

---

## 📁 Struktur Repositori

```text
sawang-jumpbox/
├── ssh-server.sh        # Script otomasi pencari server & auto-login
├── newpass.sh           # Menu interaktif tambah/hapus password vault
├── list-server.txt      # Database server target
├── README.md            # Dokumentasi utama
└── pass/                # Vault password terenkripsi (.gpg)
```

---

## 📋 Persyaratan Sistem

### Sistem Operasi yang Didukung

* Ubuntu
* Debian
* CentOS
* RHEL
* Rocky Linux
* AlmaLinux
* Oracle Linux
* MobaXterm
* Cygwin
* Git Bash
* Termux

### Dependensi

Pastikan aplikasi berikut tersedia:

```bash
which bash ssh gpg sshpass
```

---

## 🔧 Instalasi Dependensi

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install bash openssh-client gnupg2 sshpass -y
```

### RHEL / CentOS / Rocky Linux

```bash
sudo yum install epel-release -y
sudo yum install bash openssh-clients gnupg2 sshpass -y
```

### MobaXterm

```bash
apt install gnupg sshpass
```

### Termux

```bash
pkg update
pkg install openssh gnupg sshpass -y
```

---

## 🚀 Instalasi

### Clone Repository

```bash
git clone https://github.com/sawangmyid/sawang-jumpbox.git
cd sawang-jumpbox

chmod +x ssh-server.sh
chmod +x newpass.sh
```

---

## ⚙️ Setup Shortcut Terminal

Edit file `.bashrc`:

```bash
nano ~/.bashrc
```

Tambahkan fungsi berikut:

```bash
akses() {
    local SCRIPT_PATH=$(find "$HOME" -name "ssh-server.sh" -print -quit 2>/dev/null)

    if [ -z "$SCRIPT_PATH" ]; then
        echo "Error: File ssh-server.sh tidak ditemukan!"
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

## 🗄️ Konfigurasi Database Server

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

## 🔐 Manajemen Password Vault

Jalankan:

```bash
./newpass.sh
```

Fitur:

* Menambah password ke vault
* Menghapus password dari vault
* Mengelola password pool
* Menampilkan daftar password yang tersedia

---

## 🖥️ Login ke Server

Contoh:

```bash
akses app132
```

Proses yang dilakukan:

1. Membaca alias dari `list-server.txt`
2. Mengambil password dari vault GPG
3. Melakukan autentikasi menggunakan `sshpass`
4. Membuka sesi SSH ke server tujuan

---

## 🔒 Keamanan

Disarankan membatasi hak akses file:

```bash
chmod 700 ssh-server.sh
chmod 700 newpass.sh
chmod 700 pass
```

---

## ⚠️ Disclaimer

Project ini disediakan **AS IS** tanpa jaminan apa pun.

Pengguna bertanggung jawab penuh atas:

* Pengelolaan kredensial
* Keamanan sistem lokal
* Hak akses file dan direktori
* Risiko kebocoran data akibat kesalahan konfigurasi

---

## 👨‍💻 Pengembang

**Sawang**

Website: https://sawang.my.id

---

## 📄 Lisensi

Distributed under the MIT License.

See `LICENSE` for more information.

