FROM dpizar/terraformers:v4

WORKDIR /terraformfiles
#  Load Secrets, that is: terraform credentials, google credentials and tfvars
# we tell docker to mount secrets with an id to the destination dst. And in the same line we execute the cat command to check if the data is correct(maybe we can remove this latter)
RUN --mount=type=secret,id=GCP_CREDENTIAL,dst=/terraformfiles/auth/terraform-svc.json cat /terraformfiles/auth/terraform-svc.json
RUN --mount=type=secret,id=TERRAFORM_CREDENTIAL,dst=/terraformfiles/auth/.terraformrc cat /terraformfiles/auth/.terraformrc 

# Change this depending where the terraform credential file will end up in the container
ENV TF_CLI_CONFIG_FILE=/terraformfiles/auth/.terraformrc
# Change this depending where the google credential file will end up in the container
ENV GOOGLE_APPLICATION_CREDENTIALS=/terraformfiles/auth/terraform-svc.json

# Run the shell script to clone repo and create infrastructure.
COPY gke.sh .
ENTRYPOINT ["bash","gke.sh"]