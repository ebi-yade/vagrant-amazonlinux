seeder:
	hdiutil makehybrid -iso -joliet -o seed.iso seed -joliet-volume-name cidata
vbox:
	VBoxManage createvm --name "$(VM)" --ostype "RedHat_64" --register && \
	VBoxManage storagectl "$(VM)" --name "SATA Controller" --add "sata" --controller "IntelAHCI" && \
	VBoxManage storagectl "$(VM)" --name "IDE Controller" --add "ide" && \
	VBoxManage storageattach "$(VM)" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $(VDI) && \
	VBoxManage storageattach "$(VM)" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium seed.iso && \
	VBoxManage modifyvm "$(VM)" --natpf1 "ssh,tcp,127.0.0.1,2222,,22" --memory 1024 --vram 8 --audio none --usb off && \
	VBoxManage startvm "$(VM)" --type headless