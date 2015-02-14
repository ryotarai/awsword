require 'tempfile'
require 'shellwords'

module Awsword
  class Editor
    def self.edit(hash)
      self.new(ENV['EDITOR'] || 'vim').edit(hash)
    end

    def initialize(editor)
      @editor = editor
    end

    def edit(hash)
      result = nil

      Tempfile.open('awsword') do |f|
        f.write(hash.to_yaml)
        f.flush
        system "#{@editor} #{Shellwords.escape(f.path)}"
        result = YAML.load_file(f.path)
      end

      if result == hash
        puts 'Not edited. abort'
        abort
      end

      result
    end
  end
end

