require 'thor'
require 'yaml'

require 'awsword'

module Awsword
  class CLI < Thor
    class_option :profile, type: :string, default: 'default'

    desc "version", "Show version"
    def version
      puts Awsword::VERSION
    end

    desc "ec2", "EC2"
    def ec2
      set_profile
      ec2 = Awsword::EC2.new
      ec2.select
    end

    desc "config", "Show config"
    def config
      set_profile
      puts Awsword::Config.default.to_hash.to_yaml
    end

    private

    def set_profile
      Config.set_profile(options[:profile])
    end
  end
end
