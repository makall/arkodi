
utils_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

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

firstrun_config() {
  if [ -f "${1:-}" ]; then
    cat $1
  else
    ${utils_dir}/firstrun/generate
  fi
}

# vim: ts=2 sw=2 sts=2 expandtab smartindent smarttab

