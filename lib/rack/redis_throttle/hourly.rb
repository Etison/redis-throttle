require 'rack'

module Rack
  module RedisThrottle
    class Hourly < TimeWindow
      def interval_name
        self.class.name
      end

      def max_per_hour(request = nil)
        @max_per_hour ||= options[:max_per_hour] || options[:max] || 3600
      end

      alias_method :max_per_window, :max_per_hour

      protected

      def cache_key(request)
        [super, Time.now.utc.strftime('%Y-%m-%dT%H')].join(':')
      end
    end
  end
end
