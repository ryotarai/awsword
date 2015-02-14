require 'yaml'
require 'hashie'

module Awsword
  class Config < Hashie::Mash
    CONFIG_FILE = '~/.awsword.yml'
    DEFAULT = {
      ec2: {
        vpc: {},
      },
    }

    def self.default
      @default ||= self.new.tap do |c|
        c.update(DEFAULT)
        path = File.expand_path(CONFIG_FILE)
        if File.exist?(path)
          c.update(YAML.load_file(path))
        end
      end
    end
  end
end
