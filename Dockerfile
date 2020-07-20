FROM google/cloud-sdk:300.0.0-alpine

COPY pull.sh /pull.sh

RUN apk update && apk add --no-cache jq

CMD ["/bin/bash", "/pull.sh"]
