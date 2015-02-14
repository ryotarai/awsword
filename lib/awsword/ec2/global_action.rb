require 'awsword'

module Awsword
  class EC2
    module GlobalAction
      class Base
        def self.description
          raise NotImplementedError
        end

        def initialize(client)
          @client = client
        end

        def run
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

require 'awsword/ec2/global_action/launch_instance'

