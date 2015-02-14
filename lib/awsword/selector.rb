require 'open3'

module Awsword
  class Selector
    Error = Class.new(StandardError)

    def self.default
      self.new("peco --null")
    end

    def initialize(bin)
      @bin = bin
    end

    def select_from(candidates)
      object_id = nil

      Open3.popen3(@bin) do |stdin, stdout, stderr, wait_thr|
        candidates.each do |display, value|
          stdin.puts "#{display}\x00#{value.object_id}"
        end
        stdin.close

        object_id = stdout.read.to_i

        abort unless wait_thr.value.exitstatus == 0
      end

      candidates.each_value.find do |value|
        value.object_id == object_id
      end
    end
  end
end
