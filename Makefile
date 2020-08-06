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
cleanup:
	ssh -p 2222 ec2-user@localhost -i insecure.pem " \
	sudo rm -rf /var/cache/yum && \
	sudo dd if=/dev/zero of=/0 bs=4k && \
	sudo rm -f /0 && \
	history -c && \
	sudo shutdown -h now "
vagrant-init:
	vagrant package --base "$(VM)" --output amzn2.box && \
	vagrant box add --name amzn2-$(PROJECT_NAME) amzn2.box && \
	vagrant plugin install vagrant-vbguest && \
	vagrant up