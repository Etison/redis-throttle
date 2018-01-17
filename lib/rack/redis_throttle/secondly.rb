require 'rack'

module Rack
  module RedisThrottle
    class Secondly < TimeWindow
      def interval_name
        self.superclass.name
      end

      def max_per_second(request)
        @max_per_second ||=  options[:max_per_second] || options[:max] || 200
      end

      alias_method :max_per_window, :max_per_second

      protected

      def cache_key(request)
        [super, Time.now.utc.strftime('%Y-%m-%d_%H:%M:%S')].join(':')
      end
    end
  end
end
