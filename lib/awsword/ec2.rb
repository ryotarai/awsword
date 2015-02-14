require 'aws-sdk'

require 'awsword/ec2/instance_action'
require 'awsword/ec2/global_action'

module Awsword
  class EC2
    UnexpectedError = Class.new(StandardError)

    def select
      candidates = {}

      candidates["==== Actions ===="] = :nothing

      GlobalAction.all.each do |action|
        candidates["(#{action.description})"] = action.new(client)
      end

      candidates["=== Instances ==="] = :nothing

      client.instances.each do |instance|
        name_tag = instance.tags.find {|tag| tag.key == 'Name' }
        next unless name_tag

        candidates[name_tag.value] = instance
      end

      selected = Selector.default.select_from(candidates)

      case selected.first
      when Aws::EC2::Instance
        handle_instances(selected)
      when GlobalAction::Base
        selected.first.run
      when :nothing
        # pass
      else
        raise UnexpectedError, "#{selected} is unknown."
      end
    end

    private

    def handle_instances(instances)
      action = select_instance_action
      action.new(instances).run
    end

    def select_instance_action
      candidates = {}
      InstanceAction.all.each do |action|
        candidates[action.description] = action
      end

      Selector.default.select_from(candidates).first
    end

    def client
      @client ||= Aws::EC2::Resource.new
    end
  end
end
