.PHONY: vim make git

vim:
	sudo apt-get install vim -y

# includes make and the gcc compilers
init:
	sudo apt-get update
	sudo apt-get install build-essential -y	

git-install:
	sudo apt install git-all -y

git-init:
	git config --global user.name "$(git-user)"
	git config --global user.email "$(git-email)"
	git config --list  # to test
