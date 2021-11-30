ARG  VERSION=3.13.6
FROM alpine:${VERSION}

#Notes: Uses alpine to build a container as an executable running terraform version 1.0.10

LABEL maintainer            = "Terraformers <https://github.com/ycit-team-terraformers>"
LABEL authors               = "Terraformers YCIT021"
LABEL site                  = "https://github.com/ycit-team-terraformers"
LABEL description           = "Container able to run terraform. Container to be used as an executable."

LABEL note.a                = "ENTRYPOINT is terraform."
LABEL note.b                = "init is default parameter specified in the form CMD [param] If the user specifies arguments to docker run command, then new arguments will override the default specified in CMD."

LABEL change.new-a           ="Added volume 'terraformfiles' to use as working folder, terraform scripts expected here."
LABEL change.new-b           ="Added ENV TF_CLI_CONFIG_FILE to point to a file having the token to connect to Terraform Cloud, file should be named .terraformrc under the volume created terraformfiles."
LABEL change.new-c           ="Added symbolink link /root/.terraform.d to volume /terraformfiles. when using terraform login command the token files will be placed in the mounted volume."
LABEL change.new-d           ="Downloads terraform from hashicorp official release page."

ENV TERRAFORM_VERSION=1.0.11
ENV TF_DEV=true
ENV TF_RELEASE=true
ENV TF_CLI_CONFIG_FILE=/terraformfiles/.terraformrc
# Change this depending where the credential file will end up in the container
ENV GOOGLE_APPLICATION_CREDENTIALS=/terraformfiles/auth/terraform-svc.json

RUN echo "Start building" \
    # Download terraform version, unzip, move executable to path and removes zip file.
    && wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && mv terraform /usr/bin/terraform \
    #Delete cache files
    && rm -rf /var/cache/apk/* \
    # Set working folder required to grab token when running terraform login 
    && mkdir -p /root/.terraform.d \
    && ln -sf /root/.terraform.d /terraformfiles

# Set volume and working folder
VOLUME /terraformfiles
WORKDIR /terraformfiles

# Set executable for the container
ENTRYPOINT ["terraform"]
CMD ["init"]