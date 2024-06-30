.PHONY: all init git-install git-init\

# --- globals
BUILD_DIR := build

# --- common 
# if local build file required
build-tmp-dir:
	@echo "# running - build-tmp-dir"
	@echo "creating - $(BUILD_DIR)"
	mkdir -p $(BUILD_DIR)

# --- unique
# includes make and the gcc compilers
init:
	@echo "# running - init"
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get install build-essential vim perl curl -y	

git-install:
	@echo "# running - git-install"
	sudo apt install git-all -y

git-init:
	@echo "# running - get-init"
	git config --global user.name "$(git-user)"
	git config --global user.email "$(git-email)"
	git config --list  # verify

python-install:
	@echo "# running - python install"
	@echo "installing python"
	sudo apt install python3 -y
	@echo "installing pip"
	sudo apt install python3-pip -y