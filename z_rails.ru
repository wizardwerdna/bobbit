#!/usr/bin/env rackup
# This file is used by Rack-based servers to start the application.
require ::File.expand_path('z_rails/main')
run Bobbit::Main.new
