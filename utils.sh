
utils_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

EXIT_SUCCESS="$(true && echo $?)"
EXIT_FAILURE="$(false || echo $?)"

confirm() {
  echo "$@ (yes/no)?"
  read response
  if [ "${response}" != "yes" -a "${response}" != "no" ]; then
    error 'The response should be "yes" or "no"'
  elif [ "${response}" = "no" ]; then
    return ${EXIT_FAILURE}
  else
    return ${EXIT_SUCCESS}
  fi
}

depends_check() {
  for depend in $1; do
    if [ $(grep "${depend}" "$0" | wc -l) -lt 2 ]; then
      echo -e "\e[33mINFO\e[m ${depend} is not a dependency" >&2
    elif ! which ${depend} &> /dev/null; then
      error "This script depens on ${depend}" >&2
    fi
  done
}

error() {
  echo -e "\e[31mERROR\e[m $@" >&2
  exit ${EXIT_FAILURE}
}

firstrun_config() {
  if [ -f "${1:-}" ]; then
    cat $1
  else
    ${utils_dir}/firstrun/generate
  fi
}

platform_list_helper() {
  for platform in ${utils_dir}/firstrun/*; do
    [ ! -d "${platform}" ] && continue
    [[ "${platform}" =~ "_" ]] && continue
    [[ "base recommended optional" =~  "${platform##*/}" ]] && continue
    echo -n " ${platform##*/}"
  done
}

platform_list() {
  local platforms="$(platform_list_helper)"
  echo "${platforms:1}"
}

# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

