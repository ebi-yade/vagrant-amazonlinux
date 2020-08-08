seeder:
	hdiutil makehybrid -iso -joliet -o seed.iso seed -joliet-volume-name cidata
vbox:
	VBoxManage createvm --name "amzn2-$(PROJECT_NAME)" --ostype "RedHat_64" --register && \
	VBoxManage storagectl "amzn2-$(PROJECT_NAME)" --name "SATA Controller" --add "sata" --controller "IntelAHCI" && \
	VBoxManage storagectl "amzn2-$(PROJECT_NAME)" --name "IDE Controller" --add "ide" && \
	VBoxManage internalcommands sethduuid "$(PWD)/$(VDI)" && \
	VBoxManage storageattach "amzn2-$(PROJECT_NAME)" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $(VDI) && \
	VBoxManage storageattach "amzn2-$(PROJECT_NAME)" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium seed.iso && \
	VBoxManage modifyvm "amzn2-$(PROJECT_NAME)" --natpf1 "ssh,tcp,127.0.0.1,2222,,22" --memory 1024 --vram 8 --audio none --usb off && \
	VBoxManage startvm "amzn2-$(PROJECT_NAME)" --type headless
cleanup:
	# when this flow end in failure, please consider # escaping line 18 (dd command)
	ssh-keygen -R [localhost]:2222 && \
	chmod 600 insecure.pem && \
	ssh -p 2222 ec2-user@localhost -i insecure.pem " \
	sudo rm -rf /var/cache/yum && \
	sudo rm -f /0 && \
	history -c && \
	sudo shutdown -h now"
vagrant-init:
	cp Vagrantfile.bak Vagrantfile && \
	sed -i.bak -e "s/VmBoxNameHere/amzn2-$(PROJECT_NAME)/g" Vagrantfile && \
	vagrant package --base "amzn2-$(PROJECT_NAME)" --output amzn2.box && \
	vagrant box add --name amzn2-$(PROJECT_NAME) amzn2.box && \
	vagrant plugin install vagrant-vbguest && \
	vagrant up