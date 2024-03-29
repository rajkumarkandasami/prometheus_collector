# frozen_string_literal: true

module PrometheusCollector::Metric
  class Gauge < Base
    attr_reader :data

    def initialize(name, help)
      super
      @data = {}
    end

    def type
      "gauge"
    end

    def metric_text
      @data.map do |labels, value|
        "#{prefix(@name)}#{labels_text(labels)} #{value}"
      end.join("\n")
    end

    def observe(value, labels = {})
      if value.nil?
        data.delete(labels)
      else
        if !(Numeric === value)
          raise ArgumentError, 'value must be a number'
        end
        @data[labels] = value
      end
    end

    alias_method :set, :observe

    def increment(labels = {}, value = 1)
      @data[labels] ||= 0
      @data[labels] += value
    end

    def decrement(labels = {}, value = 1)
      @data[labels] ||= 0
      @data[labels] -= value
    end
  end
end
