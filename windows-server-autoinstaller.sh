#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows2016.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195174&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2016.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://download1322.mediafire.com/p7ogpsuhh3ugjF5fYWk3qJu2Je6_eHqBfJ6YMrfHMcGxBg46MPiCcxeKSRe6pCJ2Vi9_xXD4gaf18IYbVW3ZG9QnOEIYXG3QSJTSzpcU6_Ccw4f3zfspvgIr6QUHwVNVO2GIKm3p6h4eBIBKBnlIQ_fHD1m92WaI_RtiXpeAfIuCQUao/4q64m77dxys54kf/WIN10.PRO.AIO.U18.X64.%28WPE%29.ISO"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="https://download1324.mediafire.com/q82b4g566mtgTx7q_TLPfJOtioNF91punW4XW8nDuTzm4dVknw-uXCUmvbasVb7y3OjwUr2Bz7PnXfhtg0Czdov-xZcgOLHvmn0HS4d-oH0DRZiyBDfUm8lned8X5Y_N3AANfHdDZj1EhTHjQOsP9F1ImUvK2BzhMRI031avQ_W3p8wu/aisvgelvpjj1gul/WIN11.PRO.22H2.U18.X64.%28WPE%2B%29.ISO"
        iso_file="windows11.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
