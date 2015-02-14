module Awsword
  class EC2
    module InstanceAction
      class Base
        def self.description
          raise NotImplementedError
        end

        def do(instance)
          raise NotImplementedError
        end
      end

      def self.all
        self.constants.map do |const|
          self.const_get(const)
        end.select do |klass|
          klass.superclass == Base
        end
      end
    end
  end
end

require 'awsword/ec2/instance_action/ssh'

