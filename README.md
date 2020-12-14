# google-gha-demo-infra

This repo contains Terraform configs used for [Automating CI/CD pipelines with GitHub Actions and Google Cloud](https://resources.github.com/webcasts/Automating-CI-CD-Actions-Google-Cloud/) talk. For the app and workflows used in the talk checkout this [repo](https://github.com/bharathkkb-org/google-gha-demo-app). This can be used to spin up MIG GitHub Actions [self-hosted runners](https://docs.github.com/en/free-pro-team@latest/actions/hosting-your-own-runners/about-self-hosted-runners), a private GKE cluster and associated infra (project, networks, service accounts, API enablement etc). 

This can also create the [Service Account key used by Github Actions to auth](https://github.com/google-github-actions/setup-gcloud#inputs) by setting `create_sa_key = true` and automatically add this as a Github Secret to your repo by setting `create_github_secrets = true` (Additional auth for Github needed as described [here](https://www.terraform.io/docs/providers/github/index.html#token)).

## Requirements

Before this config, you must ensure that the following pre-requisites are fulfilled:

1. Project creator permissions in a GCP org
1. GitHub repo and PAT token to generate Self Hosted Runner Token

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_members | List of users, groups, SAs who need access to the bastion host | `list(string)` | `[]` | no |
| billing\_account | The billing account to associate project with | `string` | n/a | yes |
| cluster\_name | The name of the cluster | `string` | `"prod-cluster"` | no |
| folder\_id | The folder to create project in | `string` | `null` | no |
| gh\_token | Github token that is used for generating the Self Hosted Runner Token | `string` | n/a | yes |
| ip\_range\_pods\_name | The secondary ip range to use for pods | `string` | `"ip-range-pods"` | no |
| ip\_range\_services\_name | The secondary ip range to use for pods | `string` | `"ip-range-svc"` | no |
| ip\_source\_ranges\_ssh | Additional source ranges to allow for ssh to bastion host. 35.235.240.0/20 allowed by default for IAP tunnel. | `list(string)` | `[]` | no |
| network\_name | The name of the network being created to host the cluster in | `string` | `"prod-network"` | no |
| org\_id | The org to create project in | `string` | n/a | yes |
| region | The region to host the cluster in | `string` | `"us-central1"` | no |
| repo\_name | Name of the repo for the Github Action | `string` | n/a | yes |
| repo\_owner | Owner of the repo for the Github Action | `string` | n/a | yes |
| runner\_subnet\_ip | The cidr range of the runner subnet | `string` | `"10.10.20.0/24"` | no |
| subnet\_ip | The cidr range of the subnet | `string` | `"10.10.10.0/24"` | no |
| subnet\_name | The name of the subnet being created to host the cluster in | `string` | `"prod-subnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_kubectl\_command | kubectl command using the local proxy once the bastion\_ssh command is running |
| bastion\_name | Name of the bastion host |
| bastion\_ssh\_command | gcloud command to ssh and port forward to the bastion host command |
| bastion\_zone | Location of bastion host |
| ca\_certificate | Cluster ca certificate (base64 encoded) |
| cluster\_name | Cluster name |
| endpoint | Cluster endpoint |
| get\_credentials\_command | gcloud get-credentials command to generate kubeconfig for the private cluster |
| gha\_sa | SA used by GitHub to auth GCP |
| location | Cluster location (region if regional cluster, zone if zonal cluster) |
| master\_authorized\_networks\_config | Networks from which access to master is permitted |
| network\_name | The name of the VPC being created |
| region | Subnet/Router/Bastion Host region |
| router\_name | Name of the router that was created |
| subnet\_name | The name of the VPC subnet being created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
