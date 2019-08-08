require "test_helper"

class PrometheusCollectorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PrometheusCollector::VERSION
  end
end
