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
  local url=$2

  kickstart --directory $directory $url 2>/dev/null
}

function list_templates {

  local template=$1
  local -a templates=(
    'cc-sample'
    'qt-sample'
    'qt-timer-sample'
  )

  f() { printf "  • %s\n" $1 }

  echo "The \`$template\` template is missing.\n"
  echo "Here's a list of available templates:\n"
  each f $templates
}

##
## ::: Entry point :::
##
function main TRAPEXIT {

  local ks_command=${args[1]}
  local ks_template=${args[-1]}
  local ks_url=$url

  [[ $ks_command == 'gen' ]] \
    && (create_project $ks_template $ks_url || list_templates $ks_template) \
    || print_ks_commands
}

