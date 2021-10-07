# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :rundeck => {
        :box_name => "centos/7",
        :memory => 4096,
        :cpus => 4,
        :ip_addr => '10.100.100.100'
  },
  :debian => {
        :box_name => "debian/stretch64",
        :memory => 4096,
        :cpus => 4,
        :ip_addr => '10.100.100.101'
  },
  :ubuntu => {
        :box_name => "ubuntu/focal64",
        :memory => 4096,
        :cpus => 4,
        :ip_addr => '10.100.100.102'
  },
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          # Disable Gueast Additions install
          box.vbguest.auto_update = false
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            vb.memory = boxconfig[:memory]
            vb.cpus = boxconfig[:cpus]
          end
          
          box.vm.provision "shell", inline: <<-SHELL
            localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
            sed -i 's/#PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
            systemctl restart sshd
          SHELL

      end

  end

  config.vm.define "rundeck" do |rundeck|
    rundeck.vm.network "forwarded_port", guest: 4440, host: 4440
    rundeck.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end
end
