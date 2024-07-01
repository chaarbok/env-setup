.PHONY: all init git-install git-init\

# --- globals
BUILD_DIR := build
GO_VER ?= 1.22.4
GO_PACKAGE := go$(GO_VER).linux-amd64.tar.gz
GO_PATH := /usr/local/go

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
	@echo "# running - python-install"
	@echo "installing python"
	sudo apt install python3 -y
	@echo "installing pip"
	sudo apt install python3-pip -y
	@ echo "verifying installs"
	python3 --version  # verify
	pip3 --version  # verify

go-install:
	@echo "# running - go-install"
	wget https://go.dev/dl/$(GO_PACKAGE)
	sudo rm -rf $(GO_PATH)
	sudo tar -C /usr/local -xzf $(GO_PACKAGE)
	rm -rf $(GO_PACKAGE)
	@if ! grep -qF "PATH=$(GO_PATH)/bin" /etc/environment; then \
		echo "PATH=$(GO_PATH)/bin:$$PATH" | sudo tee -a /etc/environment > /dev/null; \
	fi
	go version