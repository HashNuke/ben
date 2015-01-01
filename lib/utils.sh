asdf_version() {
  echo "0.1"
}


asdf_dir() {
  if [ -z $ASDF_DIR ]
    then
    export ASDF_DIR=$(cd $(dirname $(dirname $0)); echo $(pwd))
  fi

  echo $ASDF_DIR
}


run_callback_if_command() {
  if [ "$1" = "$2" ]
    then
    $3 ${@:4}
    exit 0
  fi
}


check_if_source_exists() {
  if [ ! -d $1 ]
    then
    display_error "No such package"
    exit 1
  fi
}


list_package_installs() {
  local package=$1
  local package_installs_path=$(asdf_dir)/installs/${package}

  if [ -d $package_installs_path ]
    then
    #TODO check if dir is empty and show message here too
    for install in ${package_installs_path}/*/; do
      echo "$(basename $install)"
    done
  else
    echo 'Oohes nooes ~! Nothing found'
  fi
}
