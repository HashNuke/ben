run_command() {
  if [ $# -eq 0 ]; then
    echo "Yes zero args"
    #TODO run_tutorial
  fi

  local callback_args="${@:2}"

  run_callback_if_command "--version" $1 ben_version        $callback_args
  run_callback_if_command "list"      $1 list_command       $callback_args
  run_callback_if_command "set"       $1 set_command        $callback_args
  run_callback_if_command "show"      $1 show_command       $callback_args
  run_callback_if_command "new"       $1 new_command        $callback_args

  run_callback_if_command "install"   $1 install_command    $callback_args
  run_callback_if_command "uninstall" $1 uninstall_command  $callback_args
  run_callback_if_command "update"    $1 help_command       $callback_args

  run_callback_if_command "help"      $1 help_command       $callback_args

  help_command
  exit 1
}


show_command() {
  #TODO read from ben_status.txt
  if [ -f ben_status.txt ]; then
    echo $(cat ben_status.txt)
  else
    if [ "$1" != "silent" ]; then
      echo 'Ohoes noooes ~! No tutorial set. \nRun `ben help` for help'
    else
      echo "__NOT_SET__"
    fi
  fi
}


list_command() {
  local current_tutorial=$(show_command "silent")

  #TODO tutorials path might have to be calculated
  for d in tutorials/* ; do
    if [ $current_tutorial = "$d" ]; then
      echo "$d"
    fi
  done
}


set_command() {
  local tutorial_path=$(get_tutorial_path $1)
  check_if_tutorial_exists $tutorial_path
  echo "$1" > $(ben_dir)/ben_status.txt
}


install_command() {
  local tutorial_name=$1
  local tutorial_url=$2
  local tutorial_path=$(get_tutorial_path $tutorial_name)

  mkdir -p $(ben_dir)/tutorials
  git clone $tutorial_url $tutorial_path
}


uninstall_command() {
  local tutorial_name=$1
  local tutorial_path=$(get_tutorial_path $tutorial_name)

  rm -rf $tutorial_path
}


update_command() {
  local package_name=$1
  if [ "$package_name" = "--all" ]
    then
    for dir in $(asdf_dir)/sources/*; do (cd "$dir" && git pull); done
  else
    local source_path=$(get_source_path $package_name)
    check_if_source_exists $source_path
    (cd $source_path; git pull)
  fi
}


help_command() {
  echo "display help message"
}
