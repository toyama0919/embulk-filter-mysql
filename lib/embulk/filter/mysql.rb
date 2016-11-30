# coding: UTF-8
require 'ffi-mysql'
require_relative 'mysql/field'

module Embulk
  module Filter
    class Mysql < FilterPlugin
      Plugin.register_filter("mysql", self)

      def self.transaction(config, in_schema, &control)
        task = {
          "host" => config.param("host", :string, default: 'localhost'),
          "user" => config.param("user", :string),
          "password" => config.param("password", :string),
          "database" => config.param("database", :string),
          "port" => config.param("port", :integer, default: 3306),
          "query" => config.param("query", :string),
          "params" => config.param("params", :array),
          "keep_input" => config.param("keep_input", :bool, default: false)
        }
        connection = ::Mysql.real_connect(task['host'], task['user'], task['password'], task['database'], task['port'])
        Embulk.logger.info "PREPARE SQL:\n#{task['query']}"
        statement = connection.prepare(task['query'])
        columns = []
        columns = columns + in_schema if task['keep_input']

        statement.result_metadata.fetch_fields.each do |field|
          columns << Column.new(nil, field.name, get_type(field.name, field.type))
        end

        yield(task, columns)
      end

      def self.get_type(name, type)
        case type
        when Mysql::Field::TYPE_TINY
          :boolean
        when Mysql::Field::TYPE_SHORT, Mysql::Field::TYPE_LONG
          :long
        when Mysql::Field::TYPE_DOUBLE, Mysql::Field::TYPE_FLOAT
          :double
        when Mysql::Field::TYPE_DATE, Mysql::Field::TYPE_DATETIME, Mysql::Field::TYPE_TIMESTAMP
          :timestamp
        when Mysql::Field::TYPE_BLOB, Mysql::Field::TYPE_STRING, Mysql::Field::TYPE_VAR_STRING, Mysql::Field::TYPE_VARCHAR
          :string
        else
          raise ConfigError.new "Not support column [#{name}], type_no => [#{type}]"
        end
      end

      def init
        @connection = ::Mysql.real_connect(task['host'], task['user'], task['password'], task['database'], task['port'])
        @statement = @connection.prepare(task['query'])
        @params = task['params']
        @keep_input = task['keep_input']
      end

      def close
        Embulk.logger.info "connection closing..."
        @connection.close
      end

      def add(page)
        page.each do |record|
          hash = Hash[in_schema.names.zip(record)]
          prepare_params = @params ? @params.map{ |param| hash[param] } : []
          query_results = @statement.execute(*prepare_params)
          query_results.each do |values|
            converted = []
            converted = record + converted if @keep_input
            values.each do |value|
              converted << cast(value)
            end
            page_builder.add(converted)
          end
        end
      end

      def finish
        page_builder.finish
      end

      def cast(value)
        if (value.class == String)
          value.force_encoding('UTF-8')
        elsif (value.class == ::Mysql::Time)
          Time.local(
            value.year,
            value.month,
            value.day,
            value.hour,
            value.minute,
            value.second
          )
        else
          value
        end
      end
    end
  end
end
