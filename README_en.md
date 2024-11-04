1. Download and Install the Installer File
Run the following command to download the installer:

bash
Copy code
wget https://raw.githubusercontent.com/emuhib/windows.server.DO/main/windows-server-autoinstaller.sh
2. Grant Execution Permission to the File
After downloading, grant permission for the file to be executed:

bash
Copy code
chmod +x windows-server-autoinstaller.sh
3. Run the Installer
Run the installer with the following command:

bash
Copy code
./windows-server-autoinstaller.sh
4. Run QEMU
After the installer is complete, run QEMU to start Windows Server. Replace xx with the Windows version you chose (e.g., windows10):

bash
Copy code
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
Note: Press Enter twice to continue.

5. Access via VNC
Once QEMU is running, follow these steps to access and configure the Windows Server:

Enable Remote Desktop in Windows Server settings.
Disable CTRL+ALT+DEL in Local Security.
Set Windows Server to never sleep.
6. Compress the Windows Server File
After configuration is complete, compress the Windows Server image. Replace xxxx with the Windows version you chose (e.g., windows10):

bash
Copy code
dd if=windowsxxxx.img | gzip -c > windowsxxxx.gz
7. Install Apache
Install Apache to serve the file over the web:

bash
Copy code
apt install apache2
8. Allow Firewall Access for Apache
Allow Apache access through the firewall:

bash
Copy code
sudo ufw allow 'Apache'
9. Move the Windows Server File to the Web Location
Copy the compressed Windows Server file to the Apache web directory:

bash
Copy code
cp windowsxxxx.gz /var/www/html/
10. Download Link
Once the file is moved, access it via your droplet's IP address:

arduino
Copy code
http://[Droplet_IP]/windowsxxxx.gz
Example:

arduino
Copy code
http://188.166.190.241/windows10.gz
Running Windows Server on a New Droplet
To run Windows Server on a new droplet, use the following command. Replace LINK with the download link for the compressed file:

bash
Copy code
wget -O- --no-check-certificate LINK | gunzip | dd of=/dev/vda
Important Notes:
Make sure to replace the placeholder xxxx with the correct Windows version.
Don’t forget to replace LINK with the actual URL of your file.
