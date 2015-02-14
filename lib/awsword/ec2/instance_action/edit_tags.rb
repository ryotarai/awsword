require 'tempfile'

module Awsword
  class EC2
    module InstanceAction
      class EditTags < Base
        def self.description
          'Edit tags'
        end

        def run
          keys = @instances.map do |i|
            i.tags.map {|tag| tag.key }
          end.flatten.uniq

          tags = {}

          keys.each do |key|
            tags[key] = 'No change ('
            tags[key] += @instances.map do |i|
              tag = i.tags.find {|t| t.key == key }
              next nil unless tag
              "#{i.id}: #{tag.value}"
            end.compact.join(', ')
            tags[key] += ')'
          end

          tags = Editor.edit(tags)

          tag_keys_to_delete = []
          tags_to_update = []

          tags.each do |k, v|
            if v && !v.empty?
              next if v.start_with?('No change')
              tags_to_update << {key: k, value: v}
            else
              tag_keys_to_delete << k
            end
          end

          unless tag_keys_to_delete.empty?
            puts "Deleting tags... (#{tag_keys_to_delete.join(', ')})"
            tag_keys_to_delete.each do |k|
              @instances.each do |i|
                tag = i.tags.find {|t| t.key == k }
                tag.delete if tag
              end
            end
          end

          unless tags_to_update.empty?
            puts "Updating tags... (#{tags_to_update})"
            @instances.each do |i|
              i.create_tags(tags: tags_to_update)
            end
          end
        end
      end
    end
  end
end

