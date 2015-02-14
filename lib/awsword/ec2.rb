require 'aws-sdk'

require 'awsword/ec2/instance_action'

module Awsword
  class EC2
    UnexpectedError = Class.new(StandardError)

    def select
      candidates = {}

      client.instances.each do |instance|
        name_tag = instance.tags.find {|tag| tag.key == 'Name' }
        next unless name_tag

        candidates[name_tag.value] = instance
      end

      selected = Selector.default.select_from(candidates)

      case selected
      when Aws::EC2::Instance
        handle_instance(selected)
      else
        raise UnexpectedError, "#{selected} is unknown."
      end
    end

    private

    def handle_instance(instance)
      action = select_instance_action
      action.new.do(instance)
    end

    def select_instance_action
      candidates = {}
      InstanceAction.all.each do |action|
        candidates[action.description] = action
      end

      Selector.default.select_from(candidates)
    end

    def client
      Aws::EC2::Resource.new
    end
  end
end
