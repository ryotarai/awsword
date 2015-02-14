require 'thor'
require 'yaml'

require 'awsword'

module Awsword
  class CLI < Thor
    desc "version", "Show version"
    def version
      puts Awsword::VERSION
    end

    desc "ec2", "EC2"
    def ec2
      ec2 = Awsword::EC2.new
      ec2.select
    end

    desc "config", "Show config"
    def config
      puts Awsword::Config.default.to_hash.to_yaml
    end
  end
end
