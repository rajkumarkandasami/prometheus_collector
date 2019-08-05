
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "prometheus_collector/version"

Gem::Specification.new do |spec|
  spec.name          = "prometheus_collector"
  spec.version       = PrometheusCollector::VERSION
  spec.authors       = ["Rajkumar Kandasami"]
  spec.email         = ["rajkumar.kandasami@freshworks.com"]

  spec.summary       = %q{Prometheus Collector}
  spec.description   = %q{Prometheus metric collector and exporter for Ruby}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|bin|.idea)/})
  end

  spec.bindir        = "bin"
  spec.executables   = ["prometheus_collector"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
