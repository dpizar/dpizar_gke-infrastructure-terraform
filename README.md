# Instructions
Pull the terraform docker image from the repository https://hub.docker.com/repository/docker/dpizar/terraformers. We will run our terraform infrastructure on this iamge.
Build and run terraform docker image. You need to explicitly define the directory with the terraform files.
```
docker build -t dpizar/terraformers:v1 .
docker run --rm -it -v D:\YCIT021\terraform-scripts:/terraformfiles terraformers:v1 init // this run the image and initialize our infrastructure under the specified directory.
```

## Create infrastructure

