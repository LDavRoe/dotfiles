
echo "XCode command line tools"
xcode-select --install

echo "General settings"
sudo chflags hidden /Applications/maps.app
sudo chflags hidden /Applications/game\ center.app
sudo chflags hidden /Applications/photo\ booth.app

echo "System - Reveal IP address, hostname, OS version, etc. when clicking the login window clock\n"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "System - Require password immediately after sleep or screen saver begins\n"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "System - Avoid creating .DS_Store files on network volumes\n"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Keyboard - Turn off keyboard illumination when computer is not used for 5 minutes\n"
defaults write com.apple.BezelServices kDimTime -int 300

echo "Bluetooth - Increase sound quality for headphones/headsets\n"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "Finder - Default location is HOME"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

echo "Finder - Show the $HOME/Library folder\n"
sudo chflags nohidden $HOME/Library

echo "Finder - Show hidden files\n"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Finder - Show filename extensions\n"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder - Disable the warning when changing a file extension\n"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false


echo "Finder - Show path bar\n"
defaults write com.apple.finder ShowPathbar -bool true

echo "Finder - Show status bar\n"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Finder - Display full POSIX path as window title\n"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Finder - Use list view in all Finder windows\n"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"


echo "Printer - Expand print panel by default\n"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Disable Photos.app from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


echo "Enabled tab in modal dialogs (default: 0)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

echo "Stop launching itunes via media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

echo "Installing Homebrew"
ruby -e "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
export PATH="/usr/local/bin:$PATH"

echo "Brew installing apps"
brew install automake
brew install autoconf
brew install awscli
brew install bash-completion
brew install gnutils
brew install wget
brew install vim
brew install git
brew install node
brew install npm
brew install python3
brew install curl
brew install libevent
brew install openssl
brew install readline
brew install git
brew install git-open
brew install git-extras
brew install zsh
brew install docker
brew install docker-machine-driver-xhyve
brew install hugo
brew install ssh-copy-id
brew install golang
brew install ruby
brew install cmake
brew install enchant
brew install mkdocs
brew instal fzf
brew install the_silver_searcher
brew install jq
brew install tree
brew install xhyve
brew install kubernetes-cli
brew install kubernetes-helm
brew install kubectx
brew install shellcheck
brew install protobuf
brew install postgresql

echo "Cask installing apps"
brew cask install spectacle
brew cask install iterm2
brew cask install keybase
brew cask install keepingyouawake
brew cask install caskroom/versions/google-chrome-beta
brew cask install virtualbox
brew cask install sublime-text
brew cask install whatsapp
brew cask install slack
brew cask install gpg-suite
brew cask install minikube

if [ $(command -v kubectx) ]; then
  brew unlink kubectx
  version=$(brew info kubectx --json | jq -r '.[].versions.stable')
  ln -s /usr/local/Cellar/kubectx/$version/bin/kubectx /usr/local/bin/kctx
  ln -s /usr/local/Cellar/kubectx/$version/bin/kubens /usr/local/bin/kns
  ln -s /usr/local/Cellar/kubectx/$version/etc/bash_completion.d/kubectx /usr/local/etc/bash_completion.d/kubectx
  ln -s /usr/local/Cellar/kubectx/$version/etc/bash_completion.d/kubens /usr/local/etc/bash_completion.d/kubens
fi

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install miniconda"
wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda3

conda config --set auto_activate_base false

echo "Setup dotfiles"
mkdir -p $HOME/.config/lucas
ln -sf $(pwd)/aliases $HOME/.config/lucas/aliases.sh
ln -sf $(pwd)/functions.sh $HOME/.config/lucas/functions.sh
ln -sf $(pwd)/mac $HOME/.config/lucas/mac.sh
ln -sf $(pwd)/bashrc $HOME/.bashrc
ln -sf $(pwd)/zshrc $HOME/.zshrc
ln -sf $(pwd)/gitconfig $HOME/.gitconfig
ln -sf $(pwd)/gitmessage $HOME/.gitmessage
ln -sf $(pwd)/package_control.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
ln -sf $(pwd)/user_settings.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
ln -sf $(pwd)/sublime_keybindings.sublime-keymap $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap

echo "Setup code folder"
mkdir -p $HOME/Code/go

git clone https://github.com/LucasRoesler/dotvim.git $HOME/Code/dotvim
ln -s $(pwd)/dotvim $HOME/.vim

echo "Installing Inconsolata font"
curl -sfSL -o $HOME/Library/Fonts/Inconsolata.otf http://levien.com/type/myfonts/Inconsolata.otf

echo "Setup custom bins"
mkdir $HOME/.bin
ln -sf $(pwd)/bin/git-audit $HOME/.bin/git-audit
ln -sf $(pwd)/bin/git-exclude $HOME/.bin/git-exclude
ln -sf $(pwd)/bin/git-template-clone $HOME/.bin/git-template-clone


echo "Install go dev envinroment packages"
export GOPATH=$Home/Code/go
export PATH=$PATH:$GOPATH/bin
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u github.com/golang/lint/golint
go get -u github.com/rakyll/gotest
go get golang.org/x/tools/gopls@latest

echo "Don't forget these manual tweaks:"
echo "\t- set the Caps lock to Esc"
echo "\t- resize the dock"
echo "\t- set the top-left hot corner to sleep"
echo "\t- configure Spectacles to start at login"
echo "\t- update KeepingYouAwake to start at login"
echo "\t- run \"dlite init\""
echo "\t- create an ssh key and add it to github"
echo "\t- add the ssh key to unlock at login"
echo "\t- import default iterm profile from json"
echo "\t- install vpnunlimited"
echo "\t- install videostream"
echo "\t- install zoom"
echo "\t- install gcloud from https://cloud.google.com/sdk/docs/#install_the_latest_cloud_tools_version_cloudsdk_current_version"
