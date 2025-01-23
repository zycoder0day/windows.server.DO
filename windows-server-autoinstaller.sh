#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2016"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 1124h2"
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
        iso_link="http://138.197.29.186/WIN10.ISO"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="http://138.197.29.186/WIN11.ISO"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 1021h2
        img_file="windows1124h2.img"
        iso_link="https://download1334.mediafire.com/y39ipxgzecigJt9-QWkdxzEhe0PIYFJaOk7QeD1Dn-nWXTBIXr2ow98a0yHDO55JQBmzdsjUC777IVoeI9juuI_Qo8oWQjVMz5IztMYjDkbI9McZyxEQMZKH99gdQnzg5EM5sAzFTOCqPGEx6lf5NbFb4YM1VfQGR6kS9_ovsaylkA/ivw3x96pi4vmhn8/Win11_24H2_EnglishInternational_x64.iso"
        iso_file="windows1124h2.iso"
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
