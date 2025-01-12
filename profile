
# # if running bash
# if [ -n "${BASH_VERSION}" ]; then
#   # include .bashrc if it exists
#   if [ -f "${HOME}/.bashrc" ]; then
#     . "${HOME}/.bashrc"
#   fi
# fi

export EDITOR="$(which nvim)"
MY_OS="$(uname -s)"

## I wrap all my tweaks in functions so zprof can profile them (incase something is slow)
## All of my personal tweakage then is under a function starting with my_

#load gpg/ssh env
my_load_gnome_keyring(){
  export $(gnome-keyring-daemon --start)
}

my_load_path_krew(){
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
}

my_load_path_home_bin(){
  if [ -d "${HOME}/.bin" ] ; then
    export PATH="${HOME}/.bin:${HOME}/.bin/vendor/bin/:${PATH}"
  fi
  if [ -d "${HOME}/.software/bin" ] ; then
    export PATH="${HOME}/.software/bin:${PATH}"
  fi
}

# my_load_gemstuff(){
#   #TODO: dirty, fix me up.. evaluate+learn rbenv or something else please
#   local gemstuff="${HOME}"/.gem/ruby/2.5.0/bin
#   if [ -d "${gemstuff}" ]; then
#     PATH="${gemstuff}:${PATH}"
#   fi
# }

my_load_path_rbenv(){
  #load rbenv if exists
  if [ -d "${HOME}/.rbenv/bin" ]; then
    PATH="${HOME}/.rbenv/bin:${PATH}"
  fi
  # eval "$(rbenv init -)"
}

my_load_golang(){
  export GOPATH="${HOME}/go"
  if [ -d "${GOPATH}" ]; then
    export PATH="${GOPATH}/bin:${PATH}"
  fi
  export "PATH=/usr/local/go/bin:${PATH}"
  # docker run -d -p '3030:3000' gomods/athens:latest
  # export GOPROXY=http://localhost:3300
  export GO111MODULE=on
  export GOPRIVATE="github.com/doddle/*"
  export TMPDIR=~/.gotmp/
  if [ ! -d ${TMPDIR} ]; then
    mkdir -p ${TMPDIR}
  fi
}

my_load_pip(){
  ##Python virtualenv / pip path
  export PIP_PATH="${HOME}/.local/bin"
  if [ -d "${PIP_PATH}" ]; then
    export PATH="${PIP_PATH}:${PATH}"
  fi
}

my_load_nvm(){
  if [ -e $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  fi
}

# my_load_fnm(){
#   if [ -e $HOME/.fnm ]; then
#     export PATH=$HOME/.fnm:$PATH
#     eval "`fnm env`"
#   fi
# }


my_load_golang
# my_load_pip
# my_load_gemstuff
my_load_path_home_bin
my_load_path_krew
# my_load_fnm
# my_load_nvm

my_gnome_settings(){
  #disble animations
  gsettings set org.gnome.desktop.interface enable-animations false
}

# if egrep -q "gnome" <<<"${DESKTOP_SESSION}" ; then
#   my_gnome_settings
# fi

if egrep -q "i3|xinitrc|sway" <<<"${DESKTOP_SESSION}" ; then
  my_load_gnome_keyring
fi

export CHEATCOLORS=true


#vf() { fzf | xargs -r -I % $EDITOR % ;}

export ANSIBLE_NOCOWS=1
export FZF_DEFAULT_COMMAND='ag -l --nogroup  --nocolor --hidden -g ""'
export FLUX_FORWARD_NAMESPACE=flux


# https://stackoverflow.com/a/46202707
export LIBVIRT_DEFAULT_URI="qemu:///system"

export TF_PLUGIN_CACHE_DIR="${HOME}/.tf_cache"

export TERRAGRUNT_DOWNLOAD="${HOME}/.terragrunt_download"

export AWS_SDK_LOAD_CONFIG=1

# gomod athens
export GOPROXY=http://localhost:3000

