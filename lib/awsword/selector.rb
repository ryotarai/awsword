require 'open3'
require 'shellwords'

module Awsword
  class Selector
    Error = Class.new(StandardError)

    def self.default
      self.new("peco --null")
    end

    def initialize(bin)
      @bin = bin
    end

    def select_from(candidates, options = {})
      prompt = options[:prompt] || "QUERY>"
      object_ids = nil

      Open3.popen3("#{@bin} --prompt #{Shellwords.escape(prompt)}") do |stdin, stdout, stderr, wait_thr|
        candidates.each do |display, value|
          stdin.puts "#{display}\x00#{value.object_id}"
        end
        stdin.close

        object_ids = stdout.read.strip.split("\n").map(&:to_i)

        abort unless wait_thr.value.exitstatus == 0
      end

      candidates.each_value.select do |value|
        object_ids.include?(value.object_id)
      end
    end
  end
end
