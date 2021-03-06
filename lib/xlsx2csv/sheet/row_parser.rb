module Xlsx2Csv::Sheet
  class RowParser < ::Ox::Sax
    CELL_TYPE_MAP = {'s' => 'value_to_string', 'n' => 'value_to_number'}

    def initialize(strings, &block)
      @strings = strings
      @block = block
    end

    def start_element(name)
      @element_name = name
      @values = [] if @element_name == :row
    end

    def attr_value(name, value)
      if @element_name == :c
        case name
          when :r then @col_index = xls_col_index(xls_col(value.as_s))
          when :t then @value_method = CELL_TYPE_MAP[value.as_s]
        end
      elsif @element_name == :dimension && name == :ref
        @last_col_index = xls_col_index(xls_col(value.as_s.split(':').last))
      end
    end

    def value(value)
      if @element_name == :v
        @values += Array.new(@col_index - @values.count) if @values.count < @col_index
        if !@value_method.nil? && respond_to?(@value_method, true)
          @values << send(@value_method, value)
        else
          @values << value.as_s
        end
      end

      @value_method = nil
    end

    def end_element(name)
      return unless name == :row

      @values += Array.new(@last_col_index - @values.count + 1) if @values.count < @last_col_index + 1
      @block.call(@values)
    end

  private

    def xls_col(value)
      value.to_s[/^[[:alpha:]]+/]
    end

    def xls_col_index(column)
      column.chars.inject(0) { |a, char| a*26 + char.ord - 64 } - 1
    end

    def value_to_string(value)
      @strings[value.as_i]
    end

    def value_to_number(value)
      float = value.as_f
      fix = float.truncate
      float == fix ? fix : float
    end
  end
end
