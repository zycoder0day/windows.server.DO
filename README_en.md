## Installation Steps

### 1. Download and Install the Installer File
Run the following command to download the installer:

```bash
wget https://raw.githubusercontent.com/emuhib/windows.server.DO/main/windows-server-autoinstaller.sh
```

### 2. Grant Execution Permission to the File
After downloading, give the file permission to be executed:

```bash
chmod +x windows-server-autoinstaller.sh
```

### 3. Run the Installer
Run the installer with the following command:

```bash
./windows-server-autoinstaller.sh
```

### 4. Run QEMU
After the installer is complete, run QEMU to start Windows Server. Replace xx with the version of Windows you selected (e.g., windows10):

```bash
qemu-system-x86_64 \
-m 4G \
-cpu host \
-enable-kvm \
-boot order=d \
-drive file=windowsxx.iso,media=cdrom \
-drive file=windowsxx.img,format=raw,if=virtio \
-drive file=virtio-win.iso,media=cdrom \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-vnc :0
```

**Note: Press Enter twice to continue.**

### 5. Access via VNC
Once QEMU is running, follow these steps to access and configure the Windows Server:

1. Enable **Remote Desktop** in Windows Server settings.
2. Disable **CTRL+ALT+DEL** in Local Security.
3. Set Windows Server to **never sleep.**.
4. Disable Security Prevent **Logon Blank Pasword** in Local Security (if your windows doesn't use Password)

### 6. Compress the Windows Server File
After configuration is complete, compress the Windows Server image. Replace xxxx with the version of Windows you selected (e.g., windows10):

```bash
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
```

### 7. Install Apache
Install Apache to serve the file over the web:

```bash
apt install apache2
```

### 8. Allow Firewall Access for Apache
Allow Apache access through the firewall:

```bash
sudo ufw allow 'Apache'
```

### 9. Move the Windows Server File to the Web Directory
Copy the compressed Windows Server file to the Apache web directory:

```bash
cp windowsxxxx.gz /var/www/html/
```

### 10. Download Link
Once the file is moved, access it through your droplet's IP address:
```arduino
http://[IP_Droplet]/windowsxxxx.gz
```

**Example:**
```arduino
http://188.166.190.241/windows10.gz
```

## Running Windows Server on a New Droplet
To run Windows Server on a new droplet, use the following command. Replace LINK with the download link for the previously compressed file:

```bash
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
```

### Important Notes:
- Make sure to replace the placeholder xxxx with the correct Windows version.
- Don’t forget to replace LINK with the actual URL of your file.
