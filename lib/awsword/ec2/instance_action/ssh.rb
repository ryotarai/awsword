module Awsword
  class EC2
    module InstanceAction
      class Ssh < Base
        def self.description
          'Connect via SSH'
        end

        def do(instance)
          name_tag = instance.tags.find {|tag| tag.key == 'Name' }
          system 'ssh', name_tag.value
        end
      end
    end
  end
end

