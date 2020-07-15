# docker-pull-gcr

GitHub Workflow Action to pull Docker images from Google Container Registry
(GCR)

Required Inputs:
* image: The Docker image and tag, like "image:latest"

Optional Inputs:
* gcr\_location: multi-region location to upload the Docker image to. Defaults
  to gcr.io. Read more
  [here](https://cloud.google.com/container-registry/docs/pushing-and-pulling#pulling_images_from_a_registry)

Required Environment Variables:
* GCLOUD\_SERVICE\_ACCOUNT\_KEY: The service account key needed to pull from
  GCR. It is recommended that this account should only have the minimum access
  needed to push an image to GCR. Read more [here](https://cloud.google.com/container-registry/docs/advanced-authentication#json-key)
* GOOGLE\_PROJECT\_ID: The project ID associated with the Google Cloud Project.
  To find your project ID, follow instructions [here](https://support.google.com/googleapi/answer/7014113?hl=en)

## Examples

Simple example:
```ylm
uses: thompsonja/docker-pull-gcr@v0.3.0
with:
  image: "foo_image:latest"
  env:
    GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }}
    GOOGLE_PROJECT_ID: ${{ secrets.GOOGLE_PROJECT_ID }}
```

Example pulling an image from EU servers:
```ylm
uses: thompsonja/docker-pull-gcr@v0.3.0
with:
  gcr_location: "eu.gcr.io"
  image: "foo_image:latest"
  env:
    GCLOUD_SERVICE_ACCOUNT_KEY: ${{ secrets.GCLOUD_SERVICE_ACCOUNT_KEY }}
    GOOGLE_PROJECT_ID: ${{ secrets.GOOGLE_PROJECT_ID }}
```
