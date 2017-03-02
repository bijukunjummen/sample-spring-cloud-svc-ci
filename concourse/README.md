# Using Concourse

This pipeline is based on the [presentation](http://www.slideshare.net/makingx/concourse-ci-meetup-demo) and pipeline provided by [making](https://github.com/making/concourse-ci-demo):

![image](https://qiita-image-store.s3.amazonaws.com/0/1852/a560e677-2ee9-398b-4548-b64d93b87a75.png)

## Pipeline Sequence

![image](/ci/images/sequence_diagram.png "Sequence Diagram")


## How to replicate this pipeline in your env

* Fork this github repo to your own github account, [ generate the key pair and add the public key to github ](https://help.github.com/articles/generating-ssh-keys), and save the private key (~/.ssh/concourse_demo_git)
to pass to your pipeline configuration below.

* Create an S3 bucket (e.g. `sample-spring-cloud-svc-pipeline-artifacts`)
You'll need to rename this to something that isn't taken and update [pipeline.yml](pipeline.yml) to use that bucket instead.

* Setup Concourse, Sonar, Nexus

  1. Use docker compose
  ```console
    $ ./setup-docker-compose.sh
    $ export CONCOURSE_LOGIN=concourse
    $ export CONCOURSE_PASSWORD=changeme
    $ ./start.sh
  ```

* Configure Concourse Pipeline

  1. Download fly cli or synchronize
    ```console
    $ fly -t demo sync
    ```

  1. Login to the concourse and create a target
    ```console
    $ fly -t demo login -c http://${ROOT_ADDRESS}:8080 -u concourse -p changeme
    ```

  1. Configure the cloud foundry target environment in [pipeline.yml](pipeline.yml)

    Copy ci/credentials.yml.sample to ci/credentials.yml and configure for your cloud foundry deployment.

    Example:
    ```
    cf-domain: local.pcfdev.io
    cf-api: api.local.pcfdev.io
    cf-app-name: sample-spring-cloud-svc-ci
    cf-username: admin
    cf-password: admin
    cf-org: demo
    cf-space-dev: development
    cf-space-staging: staging
    cf-space-prod: production
    cf-space-test: test
    ```

  1. Upload the pipeline configure

    ```console
    $ cd ci
    $ ./set-pipeline.sh
    ```

  1. Unpause the pipeline

    ```console
    $ fly -t demo up -p demo
    ```

  1. Execute a task

    ```console
    $ CF_API=api.run.pivotal.io fly execute -c ci/tasks/smoke.yml -i gradle=gradle/ -i repo=.
    ```
