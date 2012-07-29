#!/usr/bin/env rackup
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../z_rack/main', __FILE__)
run Bobbit::Main.new
