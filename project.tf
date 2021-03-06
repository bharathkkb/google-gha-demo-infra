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

module "gke-project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 9.2.0"

  name                 = "gh-gcp-actions"
  random_project_id    = true
  org_id               = var.org_id
  billing_account      = var.billing_account
  skip_gcloud_download = true
  folder_id            = var.folder_id

  activate_apis = [
    "iam.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "containerregistry.googleapis.com",
    "container.googleapis.com",
    "iap.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}