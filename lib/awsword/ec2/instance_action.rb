module Awsword
  class EC2
    module InstanceAction
      class Base
        def self.description
          raise NotImplementedError
        end

        def initialize(instances)
          @instances = instances
        end

        def run
          raise NotImplementedError
        end
      end

      def self.all
        self.constants.map do |const|
          self.const_get(const)
        end.select do |klass|
          klass.class == Class && klass.superclass == Base
        end
      end
    end
  end
end

require 'awsword/ec2/instance_action/ssh'
require 'awsword/ec2/instance_action/edit_tags'
require 'awsword/ec2/instance_action/show_details'

