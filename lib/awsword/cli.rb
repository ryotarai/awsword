require 'thor'
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
  end
end
