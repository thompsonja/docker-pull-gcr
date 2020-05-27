FROM google/cloud-sdk

COPY pull.sh /pull.sh

CMD ["/bin/bash", "/pull.sh"]
