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

  local project_id
  if [[ -n "${GOOGLE_PROJECT_ID:-""}" ]]; then
    project_id="${GOOGLE_PROJECT_ID}"
  elif ! project_id=$(echo "${GCLOUD_SERVICE_ACCOUNT_KEY}" \
      | jq -r ".project_id"); then
    echo "GOOGLE_PROJECT_ID env var required (GitHub secret)"
    return 1
  fi
  readonly project_id

  local -r location="${INPUT_GCR_LOCATION:-"gcr.io"}"
  local -r gcr_image_name="${location}/${project_id}/${INPUT_IMAGE}"

  echo "${GCLOUD_SERVICE_ACCOUNT_KEY}" \
    | docker login -u _json_key --password-stdin "https://${location}"
  docker pull "${gcr_image_name}"
  docker tag "${gcr_image_name}" "${INPUT_IMAGE}"
  docker rmi "${gcr_image_name}"
}

docker_pull "$@"
