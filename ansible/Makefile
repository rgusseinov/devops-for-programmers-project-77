deploy:
	ansible-playbook playbook.yml --vault-password-file vault_password -i inventory.ini

encrypt:
	ansible-vault encrypt --ask-vault-password group_vars/vault.yml

decrypt:
	ansible-vault decrypt --ask-vault-password group_vars/vault.yml
