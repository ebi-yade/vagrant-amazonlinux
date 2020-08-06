# vagrant-amazonlinux

Create a VM Amazon Linux as a Base Box with VirtualBox

## Installation

To get started, make sure you have [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) installed on your system, then clone this repository and run commands below

```sh
make seeder
curl -LO https://cdn.amazonlinux.com/os-images/2.0.20200722.0/virtualbox/amzn2-virtualbox-2.0.20200722.0-x86_64.xfs.gpt.vdi
make vbox VM=vagrant-amznlinux2 VDI=amzn2-virtualbox-2.0.20200722.0-x86_64.xfs.gpt.vdi
make cleanup
make vagrant-init VM=vagrant-amznlinux2 PROJECT_NAME=<your-project-name>
```

## Reference

- [I made a beautiful Vagrant box for Amazon Linux 2 LTS (2.0.20180622.1) | Qiita](https://translate.google.co.jp/translate?hl=&sl=ja&tl=en&u=https%3A%2F%2Fqiita.com%2FShibuyaBizman%2Fitems%2Fdb503feb6be555dc32ac)
- [Create a Vagrant Base Box for Amazon Linux 2 | Qiita](https://translate.google.co.jp/translate?hl=&sl=ja&tl=en&u=https%3A%2F%2Fqiita.com%2Faibax%2Fitems%2F7fd9a874cb7e88f95488)
- [Running Amazon Linux 2 as a virtual machine onpremises | AWS Docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/amazon-linux-2-virtual-machine.html)
