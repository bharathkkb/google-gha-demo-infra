/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "runner-mig" {
  source         = "terraform-google-modules/github-actions-runners/google//modules/gh-runner-mig-vm"
  version        = "~> 0.1.0"
  project_id     = module.gke-project.project_id
  region         = var.region
  repo_name      = var.repo_name
  repo_owner     = var.repo_owner
  repo_url       = "https://github.com/${var.repo_owner}/${var.repo_name}"
  gh_token       = var.gh_token
  create_network = false
  network_name   = module.vpc.network_name
  subnet_name    = module.vpc.subnets_names[1]
  //override default startup script to install kubectl
  startup_script = file("${path.cwd}/scripts/startup.sh")
}
