#!/bin/bash -eu

docker_pull() {
  if [[ -z "${INPUT_IMAGE:-""}" ]]; then
    echo "Config missing required input 'image'"
    return 1
  fi

  if [[ -z "${GCLOUD_SERVICE_ACCOUNT_KEY:-""}" ]]; then
    echo "GCLOUD_SERVICE_ACCOUNT_KEY env var required (GitHub secret)"
    return 1
  fi

  # location, like us.gcr.io, is everything to the left of the first slash of
  # the input image, whereas the image name is everything ot the right of the
  # last slash.
  local -r location="${INPUT_IMAGE%%/*}"
  local -r image_name="${INPUT_IMAGE##*/}"

  echo "${GCLOUD_SERVICE_ACCOUNT_KEY}" \
    | docker login -u _json_key --password-stdin "https://${location}"
  docker pull "${INPUT_IMAGE}"
  docker tag "${INPUT_IMAGE}" "${image_name}"
  docker rmi "${INPUT_IMAGE}"
}

docker_pull "$@"
