#! /usr/bin/env zsh

declare -a args=($@)
declare url='https://github.com/Shamaoke/kickstart-templates'

##
## ::: Utility :::
##
function each; foreach e (${@:2}) { ${@:1:1} $e }

function print_ks_commands {

  local -a commands=('gen')

  f() { printf "%s\n" $1 }

  each f $commands
}

function create_project {

  local directory=$1
  local url=$url

  kickstart --directory $directory $url
}

##
## ::: Entry point :::
##
function main TRAPEXIT {

  local ks_command=${args[1]}
  local ks_template=${args[-1]}

  [[ $ks_command == 'gen' ]] \
    && create_project $ks_template \
    || print_ks_commands
}

