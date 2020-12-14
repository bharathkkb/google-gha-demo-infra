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

provider "github" {
  version      = "~> 3.1.0"
  organization = var.repo_owner
}

resource "github_actions_secret" "sa_key" {
  count           = var.create_github_secrets ? 1 : 0
  repository      = var.repo_name
  secret_name     = "SA_KEY_JSON"
  plaintext_value = base64decode(google_service_account_key.key[0].private_key)
}

resource "github_actions_secret" "gcp_project" {
  count           = var.create_github_secrets ? 1 : 0
  repository      = var.repo_name
  secret_name     = "GKE_PROJECT"
  plaintext_value = module.gke-project.project_id
}
