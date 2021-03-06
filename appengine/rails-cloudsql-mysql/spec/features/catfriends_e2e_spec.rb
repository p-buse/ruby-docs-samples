# Copyright 2017, Google, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "rails_helper"

RSpec.feature "Cat Friends E2E" do
  before :all do
    skip "End-to-end test skipped" unless E2E.run?

    app_yaml      = File.expand_path("../../../app.yaml", __FILE__)
    configuration = File.read(app_yaml)

    configuration.sub! "[SECRET_KEY]",                    ENV["RAILS_SECRET_KEY_BASE"]
    configuration.sub! "[YOUR_INSTANCE_CONNECTION_NAME]", ENV["CLOUD_SQL_MYSQL_CONNECTION_NAME"]

    File.write app_yaml, configuration

    @url = E2E.url
  end

  scenario "should display a list of cats" do
    visit "/"

    # This test requires that the database contain Cat data found in fixtures.

    expect(page).to have_content "A list of my Cats Ms. Paws is 2 years old! Mr. Whiskers is 4 years old!"
  end
end
