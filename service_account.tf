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

locals {
  # Broad GKE roles and push/pull GCR
  needed_roles = ["roles/container.admin", "roles/storage.admin"]
}

resource "google_service_account" "gha_gke_sa" {
  project      = module.gke-project.project_id
  account_id   = "gha-sa"
  display_name = "SA used by GitHub to auth to GCP"
}

resource "google_project_iam_member" "roles" {
  for_each = toset(local.needed_roles)
  project  = module.gke-project.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.gha_gke_sa.email}"
}

# Note: The contents of this key will be persisted to your TF state. Appropriate ACLs for the backend is advised. 
resource "google_service_account_key" "key" {
  count              = var.create_github_secrets || var.create_sa_key ? 1 : 0
  service_account_id = google_service_account.gha_gke_sa.name
}