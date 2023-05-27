require "db"
require "../libscylla"

module ScylladB
    module DBApi
        EPOCH_START = ::Time.unix(0)

        module CommonUuid
            GENERATOR = LibScylla.uuid_gen_new

            class UuidError < DB::Error
            end

            @scylla_uuid : LibScylla::ScyllaUuid

            private def from_string(s : String)
                Error.from_error(LibScylla.uuid_from_string_n(s, s.size, out scylla_uuid), UuidError)
            end

            def to_unsafe
                @scylla_uuid
            end

            def to_s 
                output = Array(LibC::Char).new(LibScylla::UUID_STRING_LENGTH, 0).to_unsafe
                LibScylla.uuid_string(@scylla_uuid, output)
                String.new(output, LibScylla::UUID_STRING_LENGTH - 1)
            end
        end

        struct Uuid
            include CommonUuid

            def initialize
                LibScylla.uuid_gen_random(GENERATOR, out @scylla_uuid)
            end

            def initialize(s : String)
                @scylla_uuid = from_string(s)
            end

            def initialize(@scylla_uuid)
            end
        end

        struct TimeUuid
            include CommonUuid

            def initialize
                LibScylla.uuid_gen_time(GENERATOR, out @scylla_uuid)
            end

            def initialize(s : String)
                @scylla_uuid = from_string(s)
            end

            def initialize(@scylla_uuid)
            end

            def to_time : ::Time
                miliseconds = LibScylla.uuid_timestamp(@scylla_uuid)
                EPOCH_START + ::Time::Span.new(nanoseconds: miliseconds * 1_000_000)
            end
        end

        struct Date 
            getter date

            def initialize(@date : ::Time)
            end

            def initialize(days : UInt32)
                @date = EPOCH_START + ::Time::Span.new(days: days)
            end

            def days : UInt32
                (@date - EPOCH_START).days.to_u32
            end

            def ==(other : self) : Bool
                @date == other.date
            end

            def to_s
                @date.to_s
            end
        end

        struct Time 
            getter time

            def initialize(@time : ::Time)
            end

            def initialize(nanoseconds : Int64)
                @time = EPOCH_START + ::Time::Span.new(nanoseconds: nanoseconds)
            end

            def total_nanoseconds : Int64
                (@time - @time.at_beginning_of_day).total_nanoseconds.to_i64
            end

            def ==(other : self) : Bool
                @time = other.time
            end

            def to_s
                @time.to_s
            end
        end
    end
end