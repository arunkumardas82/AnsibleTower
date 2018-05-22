echo $SHELL
ansible all --list-hosts
ansible all
clear
ansible all -m ping -v
pwd
cd /var/log
ls
cd secure
ls -ltr
tail -50f secure
ansible windows win_ping -v
ansible windows -m win_ping -v
ansible all -m win_ping -v
tail -f secure
tail -50f secure
cat /etc/ansible/hosts
yum -y install python-devel krb5-devel krb5-libs krb5-workstation python-pip gcc
pip install "pywinrm>=0.2.2"
ansible windows -m win_ping
export GUID=`hostname | awk -F"." '{print $2}'`
export GUID_CAP=`echo ${GUID} | tr 'a-z' 'A-Z'`
cat << EOF > /etc/krb5.conf.d/ansible.conf

[realms]

 AD1.${GUID_CAP}.EXAMPLE.OPENTLC.COM = {

 kdc = ad1.${GUID}.example.opentlc.com
 }

[domain_realm]
 .ad1.${GUID}.example.opentlc.com = AD1.${GUID_CAP}.EXAMPLE.OPENTLC.COM
EOF

cat /etc/ansible/hosts
kinit administrator@AD1.${GUID_CAP}.EXAMPLE.OPENTLC.COM
hostname
klist
pwd
cd /home/arunkumar.das-wipro.com/
tail -f /var/log/secure 
ls
cat /etc/ansible/ansible.cfg 
ls
mkdir -p roles/win_ad_install/{tasks,vars}
ls -ltr
tree roles
cat << EOF > roles/win_ad_install/tasks/main.yml
- name: Install AD-Domain-Services feature
    win_feature:
     name: AD-Domain-Services
     include_management_tools: yes
     include_sub_features: yes
  - name: Setup Active Directory Controller
    win_domain:
     dns_domain_name: "{{ ad_domain_name }}"
     safe_mode_password: "{{ ad_safe_mode_password }}"
    register: active_directory_controllers

  - name: reboot once DC created
    win_reboot:
    when: active_directory_controllers.reboot_required

  - name: List DCs in domain
    win_shell: "nltest /dclist:{{ ad_domain_name }}"
    register: domain_list

  - debug:
     var: domain_list
EOF

cd roles
ls
cd win_ad_install/
ls
cd tasks/
vi main.yml 
cd ~
GUID=`hostname | awk -F"." '{print $2}'`
cat << EOF > ./my_ad_vars.yml
ad_domain_name: ad1.${GUID}.example.opentlc.com
ad_safe_mode_password: "{{ansible_password}}"
ad_admin_user: "admin@{{ ad_domain_name}}"
ad_admin_password: "{{ansible_password}}"
EOF

ls -ltr
pwd
cd -
cd ../../..
mv /root/my_ad_vars.yml .
ls -ltr
cat my_ad_vars.yml 
cat << EOF > ad.yml
- hosts: windows
  vars_files:
    - ./my_ad_vars.yml
  roles:
    - win_ad_install
EOF

ansible-playbook ad.yml
vi /home/arunkumar.das-wipro.com/roles/win_ad_install/tasks/main.yml
ansible-playbook ad.yml
vi /home/arunkumar.das-wipro.com/roles/win_ad_install/tasks/main.yml
ansible-playbook ad.yml
vi /home/arunkumar.das-wipro.com/roles/win_ad_install/tasks/main.yml
ls
cat << EOF > roles/win_ad_install/tasks/main.yml
  - name: Install AD-Domain-Services feature
    win_feature:
     name: AD-Domain-Services
     include_management_tools: yes
     include_sub_features: yes
  - name: Setup Active Directory Controller
    win_domain:
     dns_domain_name: "{{ ad_domain_name }}"
     safe_mode_password: "{{ ad_safe_mode_password }}"
    register: active_directory_controllers

  - name: reboot once DC created
    win_reboot:
    when: active_directory_controllers.reboot_required

  - name: List DCs in domain
    win_shell: "nltest /dclist:{{ ad_domain_name }}"
    register: domain_list

  - debug:
     var: domain_list
EOF

ls
ansible-playbook ad.yml
pip install pywinrm[kerberos]
id
pwd
mkdir -p roles/win_service_config/{tasks,vars}
cat << EOF > roles/win_service_config/tasks/main.yml
---
  - name: Install Windows package
    win_chocolatey:
       name: "{{ package_name }}"
       params: "{{ parameters }}"
       state: latest
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
  - name: Start windows service
    win_service:
       name: "{{ service_name }}"
       state: started
       start_mode: auto
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
   - name: Add win_firewall_rule
     win_firewall_rule:
        name: "{{ service_name }}"
        localport: "{{ local_port }}"
        action: allow
        direction: in
        protocol: "{{ protocol_name }}"
        state: present
        enabled: yes
EOF

cat << EOF > ssh_var.yml
package_name: openssh
parameters: /SSHServerFeature
service_name: SSHD
local_port: 22
protocol_name: tcp
EOF

cat << EOF > win_ssh_server.yml
- hosts: windows
  vars_files:
    - ./ssh_var.yml
  roles:
    - win_service_config
EOF

ls -ltr
ansible-playbook win_ssh_server.yml
cat << EOF > roles/win_service_config/tasks/main.yml
---
  - name: Install Windows package
    win_chocolatey:
       name: "{{ package_name }}"
       params: "{{ parameters }}"
       state: latest
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
  - name: Start windows service
    win_service:
       name: "{{ service_name }}"
       state: started
       start_mode: auto
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
   - name: Add win_firewall_rule
     win_firewall_rule:
        name: "{{ service_name }}"
        localport: "{{ local_port }}"
        action: allow
        direction: in
        protocol: "{{ protocol_name }}"
        state: present
        enabled: yes
EOF

ansible-playbook win_ssh_server.yml
vi /home/arunkumar.das-wipro.com/roles/win_service_config/tasks/main.yml
ansible-playbook win_ssh_server.yml
cat << EOF > roles/win_service_config/tasks/main.yml
---
  - name: Install Windows package
    win_chocolatey:
       name: "{{ package_name }}"
       params: "{{ parameters }}"
       state: latest
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
  - name: Start windows service
    win_service:
       name: "{{ service_name }}"
       state: started
       start_mode: auto
    when: ansible_distribution == "Microsoft Windows Server 2012 R2 Standard"
   - name: Add win_firewall_rule
     win_firewall_rule:
        name: "{{ service_name }}"
        localport: "{{ local_port }}"
        action: allow
        direction: in
        protocol: "{{ protocol_name }}"
        state: present
        enabled: yes
EOF

ansible-playbook win_ssh_server.yml
vi /home/arunkumar.das-wipro.com/roles/win_service_config/tasks/main.yml
cd roles
ls
cd win_service_config/tasks
vi main.yml 
cd ../..
cd ..
ls
ansible-playbook win_ssh_server.yml
ls
ansible --v
ansible --version
pip install --upgrade pip
pip install --upgrade ansible
pwd
ls
cat << EOF > ad_user_vars.yml user_info:
   - { name: 'james', firstname: 'James', surname: 'Jockey', password: 'redhat@123', group_name: 'dev', group_scope: 'domainlocal'}
   - { name: 'bill', firstname: 'Bill', surname: 'Gates', password: 'redhat@123', group_name: 'dev', group_scope: 'domainlocal'}
   - { name: 'mickey', firstname: 'Mickey', surname: 'Mouse', password: 'redhat@123', group_name: 'qa', group_scope: 'domainlocal'}
   - { name: 'donald', firstname: 'Donald', surname: 'Duck', password: 'redhat@123', group_name: 'qa', group_scope: 'domainlocal'}
EOF

cd roles
ls
ls -ltr
cd roles
ls
ansible-galaxy init
ansible-galaxy init win_ad_user
ls -ltr
cd roles
ls
cd win_ad_user
ls
cd tasks
export GUID=`hostname | awk -F"." '{print $2}'`
ls
ls
cat << EOF > roles/win_ad_user/tasks/main.yml
---
- name: Create windows domain group
  win_domain_group:
    name: "{{ item.group_name }}"
    scope: "{{ item.group_scope }}"
    state: present
  with_items: "{{ user_info }}"
- name: Create AD User
  win_domain_user:
   name: "{{ item.name }}"
   firstname: "{{item.firstname }}"
   surname: "{{ item.surname }}"
   password: "{{ item.password }}"
   state: present
   email: '"{{ item.name }}"@ad1.${GUID}.example.opentlc.com'
  with_items: "{{ user_info }}"

cat << EOF > main.yml
---
- name: Create windows domain group
  win_domain_group:
    name: "{{ item.group_name }}"
    scope: "{{ item.group_scope }}"
    state: present
  with_items: "{{ user_info }}"
- name: Create AD User
  win_domain_user:
   name: "{{ item.name }}"
   firstname: "{{item.firstname }}"
   surname: "{{ item.surname }}"
   password: "{{ item.password }}"
   state: present
   email: '"{{ item.name }}"@ad1.${GUID}.example.opentlc.com'
  with_items: "{{ user_info }}"
EOF

cat main.yml 
cd ../../..
ls
cat << EOF > ad_user_group_create.yml
---
- hosts: windows
  vars_files:
    - ./ad_user_vars.yml
  roles:
    - win_ad_user
EOF

ansible-playbook ad_user_group_create.yml
kinit mickey@AD1.${GUID_CAP}.EXAMPLE.OPENTLC.COM
GUID=`hostname | awk -F"." '{print $2}'`
export GUID=`hostname | awk -F"." '{print $2}'`
export GUID_CAP=`echo ${GUID} | tr 'a-z' 'A-Z'`
kinit mickey@AD1.${GUID_CAP}.EXAMPLE.OPENTLC.COM
ssh mickey@ad1.${GUID}.example.opentlc.com
pwd
cd /home/arunkumar.das-wipro.com/roles
ls
ansible-galaxy init osp-network
cd osp-network/tasks/
vi main.yml 
cat main.yml 
 ansible all --list-hosts
ansible 'all:!windows' -m ping -v
ls -a
cd .ssh
ls
wget http://www.opentlc.com/download/ansible_bootcamp/openstack_keys/openstack.pem -O ~/.ssh/openstack.pem
chmod 400 ~/.ssh/openstack.pem
export GUID=1f93
ls
export GUID=e136
export OSP_GUID=e136
export MYKEY=~/.ssh/openstack.pem
export MYUSER=arunkumar.das-wipro.com
ansible all -i workstation-${OSP_GUID}.rhpds.opentlc.com, --private-key=~/.ssh/openstack.pem -u cloud-user -m ping
export GUID=`hostname | awk -F"." '{print $2}'`
echo $GUID
ansible localhost -m unarchive -a "src=https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz dest=/root/ remote_src=yes"
cat << EOF > /root/ansible-tower-setup-*/inventory
[tower]
tower1.${GUID}.internal
tower2.${GUID}.internal
tower3.${GUID}.internal
[database]
support1.${GUID}.internal
[all:vars]
ansible_become=true
admin_password='r3dh4t1!'

pg_host='support1.${GUID}.internal'
pg_port='5432'

pg_database='awx'
pg_username='awx'
pg_password='r3dh4t1!'

rabbitmq_port=5672
rabbitmq_vhost=tower

rabbitmq_username=tower
rabbitmq_password='r3dh4t1!'
rabbitmq_cookie=cookiemonster

rabbitmq_use_long_name=true
EOF

cd ..
ls -ltr
pwd
ls
cd ansible-tower-setup-3.2.5/
ls
/root/ansible-tower-setup-*/setup.sh
ls
cd ansible-tower-setup-3.2.5/
ls
more setup.sh 
ls
cd ansible-tower-setup-3.2.5/
ls
more setup.log 
tail -50f setup.log 
ssh tower1.7a80.internal 
vi inventory 
more setup.log 
                                                                                                                 
cd ansible-tower-setup-3.2.5/
./setup.sh -vvv
./setup.sh
ls
less setup.log 
export GUID=`hostname | awk -F"." '{print $2}'`
ansible support1.${GUID}.internal -m lineinfile -a "line='include_dir = 'conf.d'' path=/var/lib/pgsql/9.6/data/postgresql.conf"
ansible support1.${GUID}.internal -m file -a 'path=/var/lib/pgsql/9.6/data/conf.d state=directory'
ls
cat << EOF > tower-postgresql.conf
wal_level = hot_standby
synchronous_commit = local
archive_mode = on
archive_command = 'cp %p /var/lib/pgsql/9.6/data/archive/%f'
max_wal_senders = 2
wal_keep_segments = 10
synchronous_standby_names = 'slave01'
EOF

ansible support1.${GUID}.internal -m copy -a "src=/root/tower-postgresql.conf dest=/var/lib/pgsql/9.6/data/conf.d/tower-postgresql.conf"
export GUID=e136
ansible support1.${GUID}.internal  -m lineinfile -a "line='host    replication replica     0.0.0.0/0        md5' path=/var/lib/pgsql/9.6/data/pg_hba.conf"
export GUID=`hostname | awk -F"." '{print $2}'`
ansible support1.${GUID}.internal  -m lineinfile -a "line='host    replication replica     0.0.0.0/0        md5' path=/var/lib/pgsql/9.6/data/pg_hba.conf"
ansible support1.${GUID}.internal -m service -a"name=postgresql-9.6 state=restarted"
ansible support1.${GUID}.internal -m postgresql_user -a "name=replica password=r3dh4t1! role_attr_flags=REPLICATION state=present" --become-user=postgres
ansible support2.${GUID}.internal -m get_url -a "url=http://www.opentlc.com/download/ansible_bootcamp/repo/pgdg-96-centos.repo dest=/etc/yum.repos.d/pgdg-96-centos.repo"
ansible support2.${GUID}.internal -m get_url -a "url=http://www.opentlc.com/download/ansible_bootcamp/repo/RPM-GPG-KEY-PGDG-96 dest=/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-96"
ansible support2.${GUID}.internal -m yum -a "name=postgresql96-server state=present"
ansible support2.${GUID}.internal -m shell -a "export PGPASSWORD=r3dh4t1! && pg_basebackup -h support1.${GUID}.internal -U replica -D /var/lib/pgsql/9.6/data/ -P --xlog" --become-user=postgres
ansible support2.${GUID}.internal -m lineinfile -a "line='hot_standby = on' path=/var/lib/pgsql/9.6/data/postgresql.conf"
ssh support2.${GUID}.internal
pwd
cat << EOF > recovery.conf
restore_command = 'scp support1.${GUID}.internal:/var/lib/pgsql/9.6/data/archive/%f %p'
standby_mode = on
primary_conninfo = 'host=support1.${GUID}.internal port=5432 user=replica password=r3dh4t1! application_name=slave01'
EOF

ansible support2.${GUID}.internal -m copy -a "src=/root/recovery.conf dest=/var/lib/pgsql/9.6/data/recovery.conf"
ansible support2.${GUID}.internal -m service -a "name=postgresql-9.6 state=started enabled=true"
ansible support1.${GUID}.internal -m shell -a "psql -c 'select application_name, state, sync_priority, sync_state from pg_stat_replication;'" --become-user postgres
cat << EOF > /root/ansible-tower-setup-*/inventory
[tower]
tower1.${GUID}.internal
tower2.${GUID}.internal
tower3.${GUID}.internal
[database]

cat << EOF > /root/ansible-tower-setup-*/inventory
[tower]
tower1.${GUID}.internal
tower2.${GUID}.internal
tower3.${GUID}.internal
[database]
support1.${GUID}.internal

[isolated_group_osp]

workstation-${OSP_GUID}.rhpds.opentlc.com ansible_user='cloud-user' ansible_ssh_private_key_file='~/.ssh/openstack.pem'

[isolated_group_osp:vars]
controller=tower

[all:vars]
ansible_become=true
admin_password='r3dh4t1!'

pg_host='support1.${GUID}.internal'
pg_port='5432'

pg_database='awx'
pg_username='awx'
pg_password='r3dh4t1!'

rabbitmq_port=5672
rabbitmq_vhost=tower

rabbitmq_username=tower
rabbitmq_password='r3dh4t1!'
rabbitmq_cookie=cookiemonster

rabbitmq_use_long_name=true
EOF

ls
cd ansible-tower-setup-3.2.5/
ls
more inventory
hostname | awk -F'.' {print $2}
hostname
hostname |awk -F"." '{print $2}'
export GUID=`hostname |awk -F"." '{print $2}'`
/root/ansible-tower-setup-*/setup.sh
ls
tail -50f setup.log 
cd /root/ansible-tower-setup-3.2.5/
ls -ltr
date
tail -100f setup.log
