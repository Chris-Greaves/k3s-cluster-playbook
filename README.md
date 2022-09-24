# K3s Cluster Playbook

This is the playbook I created to setup my k3s cluster.

## Resources

This playbook is built using some community projects as well as some created by myself.

- https://github.com/k3s-io/k3s-ansible - The playbook on which this is was built on top of.
- https://github.com/racqspace/ansible-role-longhorn - Community built role for installing longhorn into a cluster. (not currently deployed due to [helm chart issue](https://github.com/longhorn/charts/pull/74))
- https://galaxy.ansible.com/kubernetes/core - Very useful collection for managing k8s clusters.

## System requirements

Deployment environment must have Ansible 2.4.0+
Master and nodes must have passwordless SSH access

## Usage

First create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit `inventory/my-cluster/hosts.ini` to match the system information gathered above. For example:

```bash
[master]
192.168.1.26

[node]
192.168.1.34
192.168.1.39
192.168.1.16
192.168.1.32

# Group of 1 machine that will run the kubectl commands for helm deployments, etc.
[k3s_exec]
192.168.1.172

[k3s_cluster:children]
master
node
```

If needed, you can also edit `inventory/my-cluster/group_vars/all.yml` to match your environment.

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini
```

## Kubeconfig

To get access to your **Kubernetes** cluster just

```bash
scp username@master_ip:~/.kube/config ~/.kube/config
```
