require "awsword/config"
require "awsword/ec2"
require "awsword/selector"
require "awsword/editor"
require "awsword/version"

Gem.loaded_specs.values.find do |spec|
  if spec.name == /^awsword-plugin-/
    require spec.name.gsub('-', '/')
  end
end

module Awsword
  # Your code goes here...
end
