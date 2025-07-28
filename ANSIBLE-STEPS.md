# Ansible Deployment Steps

## 🎯 Basic Ansible Commands

### Setup and Testing
```bash
# Test connectivity to all hosts
ansible all -m ping

# Test specific group
ansible webservers -m ping

# Check inventory
ansible-inventory --list

# Run ad-hoc command
ansible all -m shell -a "uptime"

# Run with sudo
ansible all -m shell -a "systemctl status docker" --become
```

### Running Playbooks
```bash
# Run main site playbook
ansible-playbook site.yml

# Run specific playbook
ansible-playbook playbooks/deploy-app.yml

# Run with specific inventory
ansible-playbook -i inventory.ini site.yml

# Dry run (check mode)
ansible-playbook site.yml --check

# Run on specific hosts
ansible-playbook site.yml --limit webservers

# Run with extra variables
ansible-playbook site.yml --extra-vars "app_version=v2.0"
```

### Common Tasks for Exams

#### 1. Install Packages
```bash
# Install Docker on all servers
ansible all -m apt -a "name=docker.io state=present" --become

# Install multiple packages
ansible webservers -m apt -a "name=nginx,git,curl state=present" --become
```

#### 2. Manage Services
```bash
# Start Docker service
ansible all -m service -a "name=docker state=started enabled=yes" --become

# Restart nginx
ansible webservers -m service -a "name=nginx state=restarted" --become
```

#### 3. Copy Files
```bash
# Copy file to servers
ansible webservers -m copy -a "src=app.conf dest=/etc/nginx/sites-available/" --become

# Copy and set permissions
ansible all -m copy -a "src=script.sh dest=/opt/script.sh mode=0755" --become
```

#### 4. Create Users and Directories
```bash
# Create user
ansible all -m user -a "name=appuser shell=/bin/bash" --become

# Create directory
ansible all -m file -a "path=/opt/app state=directory mode=0755" --become
```

## 📋 Exam-Style Playbook Examples

### Basic Server Setup
```yaml
---
- name: Setup Web Servers
  hosts: webservers
  become: yes
  
  tasks:
    - name: Update packages
      apt:
        update_cache: yes
    
    - name: Install nginx
      apt:
        name: nginx
        state: present
    
    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: yes
    
    - name: Copy website files
      copy:
        src: index.html
        dest: /var/www/html/
```

### Deploy Application
```yaml
---
- name: Deploy App
  hosts: webservers
  become: yes
  
  tasks:
    - name: Create app directory
      file:
        path: /opt/myapp
        state: directory
    
    - name: Copy docker-compose file
      copy:
        src: docker-compose.yml
        dest: /opt/myapp/
    
    - name: Start application
      shell: docker-compose up -d
      args:
        chdir: /opt/myapp
```

## 🔧 Troubleshooting Commands

```bash
# Check syntax
ansible-playbook site.yml --syntax-check

# List tasks
ansible-playbook site.yml --list-tasks

# List hosts
ansible-playbook site.yml --list-hosts

# Verbose output
ansible-playbook site.yml -v
ansible-playbook site.yml -vv   # More verbose
ansible-playbook site.yml -vvv  # Very verbose

# Skip specific tasks
ansible-playbook site.yml --skip-tags "docker"

# Run only specific tags
ansible-playbook site.yml --tags "setup"
```

## 💡 Quick Exam Tips

### Common Ansible Modules for Exams:
- `apt` - Package management
- `service` - Service management  
- `copy` - Copy files
- `file` - Create directories/files
- `user` - User management
- `shell` - Run commands
- `template` - Copy template files

### Inventory File Basics:
```ini
[webservers]
web1 ansible_host=192.168.1.10
web2 ansible_host=192.168.1.11

[databases]
db1 ansible_host=192.168.1.20

[all:vars]
ansible_user=ubuntu
```

### Simple Playbook Structure:
```yaml
---
- name: Task Description
  hosts: target_group
  become: yes  # Use sudo
  
  tasks:
    - name: Task 1
      module_name:
        parameter: value
    
    - name: Task 2
      module_name:
        parameter: value
```
