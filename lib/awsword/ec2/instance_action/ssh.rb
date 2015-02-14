module Awsword
  class EC2
    module InstanceAction
      class Ssh < Base
        def self.description
          'Connect via SSH'
        end

        def run
          fqdns = @instances.map do |instance|
            suffix = nil
            if vpc_config = Config.default.ec2.vpc[instance.vpc.id]
              suffix = vpc_config.fqdn_suffix
            end

            fqdn = instance.tags.find {|tag| tag.key == 'Name' }.value
            fqdn += suffix if suffix

            fqdn
          end

          if fqdns.size == 1
            system 'ssh', fqdns.first
          else
            system 'csshx', *fqdns
          end
        end
      end
    end
  end
end

