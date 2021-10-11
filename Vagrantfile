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
  :freebsd => {
        :box_name => "freebsd/FreeBSD-13.0-STABLE",
        :memory => 4096,
        :cpus => 4,
        :ip_addr => '10.100.100.102'
  },
}

Vagrant.configure("2") do |config|

  config.vm.define "rundeck" do |rundeck|
    rundeck.vm.network "forwarded_port", guest: 4440, host: 4440
    rundeck.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yml"
    end

    rundeck.vm.provision "shell", inline: <<-SHELL
      cat /vagrant/id_rsa > /var/lib/rundeck/.ssh/id_rsa
      cat /vagrant/id_rsa.pub > /var/lib/rundeck/.ssh/id_rsa.pub
      cat /vagrant/rundeck_ssh_config > /var/lib/rundeck/.ssh/config
      chown rundeck:rundeck /var/lib/rundeck/.ssh/config
      chmod 0400 /var/lib/rundeck/.ssh/config
    SHELL
  end

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
            cat /vagrant/hosts >> /etc/hosts
            cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
            sed -i 's/#PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
            service sshd restart
          SHELL
      end
  end
end
