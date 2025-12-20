# K3s Cluster Ansible

This is the ansible collection I created to setup my k3s cluster.

## Resources

This playbook is built using some community projects as well as some created by myself.

- https://github.com/k3s-io/k3s-ansible - The main collection which this collection uses.
- https://galaxy.ansible.com/kubernetes/core - Very useful collection for managing k8s clusters.

## System requirements

- Services and Agents must have passwordless SSH access
- The hosts should exist in known_hosts

## Usage

### Using a Dev Container

When the Dev Container starts, it'll create a readonly mount of your .ssh directory to the `~/.ssh-host` folder, which will allow you to copy the files you need from that folder to `~/.ssh`. This copy of the files means you can tweak the permissions of the files to please the very particular ssh requirements.

```bash
cp ~/.ssh-host/id_rsa ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
```

### Setup the playbook

First create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit `inventory/my-cluster/inventory.yml` to match the system information gathered above. For example:

```yaml
---
k3s_cluster:
  children:
    server:
      hosts:
        192.16.35.11:
    agent:
      hosts:
        192.16.35.12:
        192.16.35.13:
```

You'll also want to update the required variables found in the `inventory.yml` file.

```yaml
  # Required Vars
  vars:
    ansible_port: 22
    # If your hosts use a different user, change the below variable to the user name.
    # This username will be used for each host, so you might need to set this prior to running.
    ansible_user: debian
    k3s_version: v1.31.12+k3s1
    # The token should be a random string of reasonable length. You can generate
    # one with the following commands:
    # - openssl rand -base64 64
    # - pwgen -s 64 1
    # You can use ansible-vault to encrypt this value / keep it secret.
    # Or you can omit it if not using Vagrant and let the first server automatically generate one.
    token: "changeme!"
    api_endpoint: "{{ hostvars[groups['server'][0]]['ansible_host'] | default(groups['server'][0]) }}"
```

Pull the requirements down.

```bash
ansible-galaxy install -r ./collections/requirements.yml
```

Start provisioning of the cluster using the following command:

```bash
ansible-playbook playbooks/site.yml -i inventory/pi-and-clusterd/inventory.yml
```

## Kubeconfig

To get access to your **Kubernetes** cluster just

```bash
scp username@master_ip:~/.kube/config ~/.kube/config
```
