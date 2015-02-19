require 'tempfile'

module Awsword
  class EC2
    module InstanceAction
      class ShowDetails < Base
        def self.description
          'Show instance details'
        end

        def run
          @instances.each do |instance|
            tags = Hash[instance.tags.map {|t| [t.key, t.value] }]
            vpc_tags = Hash[instance.vpc.tags.map {|t| [t.key, t.value] }]
            puts ">> #{instance.id}"
            puts "Tags: #{tags}"
            puts "VPC: #{instance.vpc.id} (#{vpc_tags})"
            puts
          end
        end
      end
    end
  end
end

