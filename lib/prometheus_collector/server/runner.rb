# frozen_string_literal: true

module PrometheusCollector::Server
  class RunnerException < StandardError; end;
  class WrongInheritance < RunnerException; end;

  class Runner
    def initialize(options = {})
      options.each do |k, v|
        send("#{k}=", v) if self.class.method_defined?("#{k}=")
      end
    end

    def start
      PrometheusCollector::Metric::Base.default_prefix = prefix

      register_type_collectors

      unless collector.is_a?(PrometheusCollector::Server::CollectorBase)
        raise WrongInheritance, 'Collector class must be inherited from PrometheusCollector::Server::CollectorBase'
      end

      server = server_class.new port: port, collector: collector, timeout: timeout, verbose: verbose
      server.start
    end

    def prefix=(prefix)
      @prefix = prefix
    end

    def prefix
      @prefix || PrometheusCollector::DEFAULT_PREFIX
    end

    def port=(port)
      @port = port
    end

    def port
      @port || PrometheusCollector::DEFAULT_PORT
    end

    def collector_class=(collector_class)
      @collector_class = collector_class
    end

    def collector_class
      @collector_class || PrometheusCollector::Server::Collector
    end

    def type_collectors=(type_collectors)
      @type_collectors = type_collectors
    end

    def type_collectors
      @type_collectors || []
    end

    def timeout=(timeout)
      @timeout = timeout
    end

    def timeout
      @timeout || PrometheusCollector::DEFAULT_TIMEOUT
    end

    def verbose=(verbose)
      @verbose = verbose
    end

    def verbose
      return @verbose if defined? @verbose
      false
    end

    def server_class=(server_class)
      @server_class = server_class
    end

    def server_class
      @server_class || PrometheusCollector::Server::WebServer
    end

    def collector
      @_collector ||= collector_class.new
    end

    private

    def register_type_collectors
      type_collectors.each do |klass|
        collector.register_collector klass.new
        STDERR.puts "Registered TypeCollector: #{klass}" if verbose
      end
    end
  end
end
