require 'yaml'
require 'tempfile'
require 'shellwords'

module Awsword
  class EC2
    module GlobalAction
      class LaunchInstance < Base
        DEFAULT = {
          names: [],
          image_id: 'required',
          max_count: 1,
          min_count: 1,
          tags: {},
        }

        def self.description
          "Launch instance"
        end

        def run
          launch_options = Editor.edit(DEFAULT)

          names = launch_options.delete(:names)
          tags = launch_options.delete(:tags)

          launch_options[:max_count] = names.size
          launch_options[:min_count] = names.size

          instances = @client.create_instances(launch_options)
          puts "Instances created: #{instances.map(&:id).join(', ')}"
          instances.each_with_index do |instance, i|
            tags['Name'] = names[i]
            puts "Updating tag of #{instance.id}: #{tags}"
            instance.create_tags(tags: tags.map {|k, v| {key: k, value: v} })
          end
        end
      end
    end
  end
end

