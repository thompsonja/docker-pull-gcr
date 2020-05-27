# docker-push-gcr
GitHub Workflow Action to push Docker images to Google Container Registry (GCR)

Required Inputs:
* image: The Docker image and tag, like "image:latest"

Optional Inputs:
* gcr\_location: multi-region location to upload the Docker image to. Defaults
  to gcr.io. Read more [here](https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry)
* dockerfile: Path to the Dockerfile to build. The Docker image will be built
  from within the folder containing the dockerfile.
* docker\_build\_script: Path to a script used to build a Docker image. Use this
  if you have a more complex build script. This build script should still result
  in a Docker image being built with the same name as the {image} arg.

Both the dockerfile and docker\_build\_script args cannot be used at the same time.

Required Environment Variables:
* GCLOUD\_SERVICE\_ACCOUNT\_KEY: The service account key needed to push to GCR.
  It is recommended that this account should only have the minimum access needed
  to push an image to GCR. Read more [here](https://cloud.google.com/container-registry/docs/advanced-authentication#json-key)
* GOOGLE\_PROJECT\_ID: The project ID associated with the Google Cloud Project.
  To find your project ID, follow instructions [here](https://support.google.com/googleapi/answer/7014113?hl=en)

## Examples

Simple example:
```ylm
uses: thompsonja/docker-push-gcr
with:
  image: "foo_image:latest"
  env:
    GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }}
    GOOGLE_PROJECT_ID: ${{ secrets.GOOGLE_PROJECT_ID }}
```

Example using a specific Dockerfile, save images to EU servers only:
```ylm
uses: thompsonja/docker-push-gcr
with:
  gcr_location: "eu.gcr.io"
  image: "foo_image:latest"
  dockerfile: "path/to/Dockerfile"
  env:
    GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }}
    GOOGLE_PROJECT_ID: ${{ secrets.GOOGLE_PROJECT_ID }}
```

Example using a build script, save images to US servers only:
```ylm
uses: thompsonja/docker-push-gcr
with:
  gcr_location: "us.gcr.io"
  image: "foo_image:latest"
  docker_build_script: "path/to/docker_build_script.sh"
  env:
    GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }}
    GOOGLE_PROJECT_ID: ${{ secrets.GOOGLE_PROJECT_ID }}
```
