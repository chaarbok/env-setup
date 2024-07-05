.PHONY: init git-install git-init python-install go-install

# --- globals
BUILD_DIR := build

ENV_FILE := /etc/environment  # system wide

#GO_VER = $(shell curl -s 'https://go.dev/VERSION?m=text')  # curl for most recent version
GO_VER = 1.22.5
GO_PACKAGE = go$(GO_VER).linux-amd64.tar.gz
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
	@echo "go path: $(GO_PATH)"
	@echo "go version: $(GO_VER)"
	@echo "go package: $(GO_PACKAGE)"
	wget https://go.dev/dl/$(GO_PACKAGE)
	sudo rm -rf $(GO_PATH)
	sudo tar -C /usr/local -xzf $(GO_PACKAGE)
	rm -rf $(GO_PACKAGE)
	@if grep -qF "PATH=$(GO_PATH)/bin" $(ENV_FILE); then \
		echo "Go Path ($(GO_PATH)) already in $(ENV_FILE)"; \
	else \
		echo "PATH=\"$(GO_PATH)/bin:$$PATH\"" | sudo tee $(ENV_FILE) > /dev/null; \
	fi
	go version

test:
	echo "export PATH=\$$PATH:$(GO_PATH)" | sudo tee /etc/profile.d/gopath.sh
