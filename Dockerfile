FROM google/cloud-sdk:300.0.0-alpine

COPY pull.sh /pull.sh

CMD ["/bin/bash", "/pull.sh"]
