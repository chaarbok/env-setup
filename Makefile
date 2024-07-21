.PHONY: init git-install git-init python-install go-install

# --- globals
BUILD_DIR := build

ENV_FILE := /etc/environment  # system wide

GO_PATH = /usr/local/go

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
	git config --global user.name "$(user)"
	git config --global user.email "$(email)"
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

go-latest-version:
	@echo "# getting go's latest version"
	@echo "version: $(shell curl -s 'https://go.dev/VERSION?m=text')"

go-install:
	@echo "# running - go-install"
	@echo "go path: $(GO_PATH)"
	@echo "go version: $(GO_VER)"
	# package = go$(GO_VER).linux-amd64.tar.gz
	@echo "go package: go$(GO_VER).linux-amd64.tar.gz"
	wget https://go.dev/dl/go$(GO_VER).linux-amd64.tar.gz
	sudo rm -rf $(GO_PATH)
	sudo tar -C /usr/local -xzf go$(GO_VER).linux-amd64.tar.gz
	rm -rf go$(GO_VER).linux-amd64.tar.gz
	@if grep -qF "PATH=$(GO_PATH)/bin" $(ENV_FILE); then \
		echo "Go Path ($(GO_PATH)) already in $(ENV_FILE)"; \
	else \
		echo "PATH=\"$(GO_PATH)/bin:$$PATH\"" | sudo tee $(ENV_FILE) > /dev/null; \
	fi
	go version
