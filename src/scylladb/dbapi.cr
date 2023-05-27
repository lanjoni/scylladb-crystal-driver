require "db"
require "./libscylla"
require "./dbapi/types"
require "./dbapi/session"
require "./dbapi/statement"
require "./dbapi/result_set"
require "./dbapi/error_handler"

module ScyllaDB
    module DBApi
        class Driver < DB::Driver
            # Builds a ScyllaDB connection
            def build_connection(context : DB::ConnectionContext) : DB::ConnectionContext
                DBApi::Session.new(context)
            end
        end

        # Support to Crystal primitive types 
        #
        # Basic usage:
        # ```cr
        # db.exec("INSERT INTO table (id, name) VALUES (?, ?)", 1, "Crystal is cool")
        # ```
        #
        # Also supports query results:
        # ```cr
        # db.query("SELECT id, name FROM table") do |rs|
        #   rs.each do
        #     puts rs.read(Int32), rs.read(String)
        #   end
        # end
        # ```
        alias Primitive = DB::Any | Int8 | Int16 | DBApi::Date | DBApi::Time | DBApi::Uuid | DBApi::TimeUuid

        # Support to ScyllaDB types 
        #
        # Collections are wrapped with `ScyllaDB::DBApi::Any`. Check this example:
        # ```cr
        # db.exec("INSERT INTO table (id, address) values (?, ?)", 1, Any.new([Any.new("This is a test!")]))
        # ```
        #
        # Query result example:
        # ```cr
        # db.query("SELECT id, address FROM table") do |rs|
        #   rs.each do 
        #     puts rs.read(Int32), rs.read(Array(Any)).map(&.as_s)
        #   end
        # end
        # ```
        alias Type = Primitive | Array(Any) | Set(Any) | Hash(Any, Any)

        struct Any
            getter raw : Type

            def initialize(@raw : Type)
            end

            def ==(other : Any)
                @raw == other.raw
            end

            def ==(other)
                @raw == other
            end

            def as_nil
                @raw.as(Nil)
            end

            private macro def_for_type(as_method, type)
                def {{ as_method }} : {{ type }}
                    @raw.as({{ type }})
                end

                def {{ as_method }}? : {{ type }}?
                    {{ as_method }} if @raw.is_a?({{ type }})
                end
            end

            def_for_type(as_bool, Bool)
            def_for_type(as_i8, Int8)
            def_for_type(as_i16, Int16)
            def_for_type(as_i32, Int32)
            def_for_type(as_i64, Int64)
            def_for_type(as_f32, Float32)
            def_for_type(as_f64, Float64)
            def_for_type(as_s, String)
            def_for_type(as_bytes, Bytes)
            def_for_type(as_timestamp, ::Time)
            def_for_type(as_date, DBApi::Date)
            def_for_type(as_time, DBApi::Time)
            def_for_type(as_uuid, DBApi::Uuid)
            def_for_type(as_timeuuid, DBApi::TimeUuid)
            def_for_type(as_a, Array(Any))
            def_for_type(as_set, Set(Any))
            def_for_type(as_h, Hash(Any, Any))
        end
    end
end

DB.register_driver("scylladb", ScyllaDB::DBApi::Driver)