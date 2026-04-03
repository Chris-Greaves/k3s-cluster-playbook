copy-hosts:
    cp ~/.ssh-host/known_hosts ~/.ssh/known_hosts
    cp ~/.ssh-host/id_rsa ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa

install:
    ansible-galaxy install -r ./collections/requirements.yml

run INVENTORY PLAYBOOK:
    ansible-playbook -i inventory/{{ INVENTORY }}/inventory.yml playbooks/{{ PLAYBOOK }}.yml -v