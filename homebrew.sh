#!/usr/bin/env bash

set -e

taps=(
  homebrew/dupes
  homebrew/versions
  caskroom/cask
  caskroom/fonts
)

packages=(
  ack
  coreutils
  dnstop
  dos2unix
  exiftool
  ffmpeg
  findutils
  gist
  git
  git-extras
  'gnu-sed --default-names'
  gnu-time
  hub
  imagemagick
  ioping
  jq
  libxml2
  libxslt
  lynx
  maven
  md5sha1sum
  mtr
  netcat
  node
  pkg-config
  psgrep
  "python --with-brewed-openssl"
  "python3 --with-brewed-openssl"
  pwgen
  ruby
  sqlite
  tree
  unrar
  watch
  wdiff
  "wget --enable-iri"
  youtube-dl

  # caskroom/cask
  caskroom/cask/brew-cask
)

cask_packages=(
  # Quick look plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  scriptql
  suspicious-package
  webp-quicklook

  # Other apps
  alfred
  appcleaner
  coconutbattery
  dash
  disk-inventory-x
  # dropbox
  # evernote
  flux
  # google-chrome
  gyazo
  # hipchat
  # iterm2
  onepassword
  rescuetime
  spectacle
  # skype
  # spotify
  # sublime-text
  # the-unarchiver
  # torbrowser
  # transmission
  # virtualbox
  # vlc

  # caskroom/fonts

  # font-inconsolata
  # font-liberation-sans
  # font-open-sans
  # font-source-code-pro
  # font-source-sans-pro
)

function log() {
  echo $* > /dev/stderr
}

#########################################################################

log "brew update"
brew update

log "brew upgrade"
brew upgrade

log "Tapping.."
for name in $taps
do
  log "brew tap ${name}"
  brew tap $name
done

log "Installing"
for name_and_args in "${packages[@]}"
do
  log "brew install ${name_and_args}"
  brew install ${name_and_args}
done

for name_and_args in "${cask_packages[@]}"
do
  log "brew cask install ${name_and_args}"
  brew cask install ${name_and_args}
done

log "brew cleanup"
brew cleanup

log "brew linkapps"
brew linkapps
