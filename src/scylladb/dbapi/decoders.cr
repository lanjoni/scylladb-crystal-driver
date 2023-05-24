require "../libscylla"

module ScylladB
    module DBApi
        module Decoders
            abstract class BaseDecoder
                @@scylla_types_by_code = Hash(LibScylla::ScyllaValueType, BaseDecoder).new

                def decode(scylla_value : LibScylla::ScyllaValue)
                    if LibScylla.value_is_null(scylla_value) == LibScylla::BoolT::True
                        return nil
                    else
                        decode_with_type(scylla_value)
                    end
                end

                abstract def decode_with_type(scylla_value : LibScylla::ScyllaValue)

                def handle_error(scylla_error : LibScylla::ScyllaError)
                    Error.from_error(scylla_error)
                end

                def decode_iterator(iter : Iterator)
                    iter.map { |item| Any.new(decode_with_type(item)).as(Any) }
                end

                protected def self.scylla_value_codes : Array(LibScylla::ScyllaValueType)
                    raise NotImplementedError.new("You need to derive `scylla_value_codes`")
                end

                protected def self.auto_register? : Bool
                    true
                end

                macro inherited
                    BaseDecoder.register_type({{@type}}) if {{@type}}.auto_register?
                end

                def self.register_type(type_classs : BaseDecoder.class)
                    instance = type_class.new
                    type_class.scylla_value_codes.each do |scylla_value_code|
                        @@scylla_types_by_code[scylla_value_code] = instance
                    end
                end

                def self.get_decoder(scylla_value_type : LibScylla::ScyllaValueType)
                    @@scylla_types_by_code[scylla_value_type]
                end
            end

            class StringDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeAscii, LibScylla::ScyllaValueType::ValueTypeVarchar]
                end

                def decode_with_type(scylla_value)
                    handle_error(LibScylla.value_get_string(scylla_value, out s, out len))
                    String.new(s, len)
                end
            end

            class TinyIntDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeTinyInt]
                end

                def decode_with_type(scylla_value) : Int8
                    handle_error (LibScylla.value_get_int8(scylla_value, out i))
                    i.to_i8
                end
            end

            class SmallIntDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeSmallInt]
                end

                def decode_with_type(scylla_value) : Int16
                    handle_error (LibScylla.value_get_int16(scylla_value, out i))
                    i
                end
            end

            class IntDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeInt]
                end

                def decode_with_type(scylla_value) : Int32
                    handle_error (LibScylla.value_get_int32(scylla_value, out i))
                    i
                end
            end

            class BigIntDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeBigInt]
                end

                def decode_with_type(scylla_value) : Int64
                    handle_error (LibScylla.value_get_int64(scylla_value, out i))
                    i
                end
            end

            class FloatDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeFloat]
                end

                def decode_with_type(scylla_value) : Float32
                    handle_error (LibScylla.value_get_float(scylla_value, out f))
                    f
                end
            end

            class DoubleDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeFloat]
                end

                def decode_with_type(scylla_value) : Float64
                    handle_error (LibScylla.value_get_double(scylla_value, out f))
                    f
                end
            end

            class DateDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeDate]
                end

                def decode_with_type(scylla_value) : DBApi::Date
                    handle_error (LibScylla.value_get_uint32(scylla_value, out days))
                    Date.new(days)
                end
            end

            class TimeDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeTime]
                end

                def decode_with_type(scylla_value) : DBApi::Time
                    handle_error (LibScylla.value_get_int64(scylla_value, out nanoseconds))
                    Time.new(nanoseconds)
                end
            end

            class Timestamp < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeTimestamp]
                end

                def decode_with_type(scylla_value) : ::Time
                    handle_error (LibScylla.value_get_int64(scylla_value, out miliseconds))
                    ::Time.unix_ms(miliseconds)
                end
            end

            class UuidDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeUuid]
                end

                def decode_with_type(scylla_value) : Uuid
                    handle_error (LibScylla.value_get_uuid(scylla_value, out scylla_uuid))
                    Uuid.new(scylla_uuid)
                end
            end

            class TimeUuidDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeTimeUuid]
                end

                def decode_with_type(scylla_value)
                    handle_error (LibScylla.value_get_uuid(scylla_value, out scylla_uuid))
                    TimeUuid.new(scylla_value)
                end
            end

            class BooleanDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeBoolean]
                end

                def decode_with_type(scylla_value) : Bool
                    handle_error (LibScylla.value_get_bool(scylla_value, out val))
                    val == LibScylla::BoolT::True
                end
            end

            class BytesDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeBlob]
                end

                def decode_with_type(scylla_value)
                    handle_error (LibScylla.value_get_bytes(scylla_value, out s, out len))
                    Bytes.new(s, len)
                end
            end

            private class ScyllaCollectionIterator
                include Iterator(LibScylla::ScyllaValue)

                def initialize(scylla_list : LibScylla::ScyllaValue)
                    @scylla_iterator = LibScylla.iterator_from_collection(scylla_list)
                end

                def finalize
                    LibScylla.iterator_free(@scylla_iterator)
                end

                def next
                    if LibScylla.iterator_next(@scylla_iterator) == LibScylla::BoolT::True
                        LibScylla.iterator_get_value(@scylla_iterator)
                    else
                        stop
                    end
                end
            end

            class ListDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeList]
                end

                def decode_with_type(scylla_value)
                    subtype = LibScylla.value_primary_sub_type(scylla_value)
                    decoder = BaseDecoder.get_decoder(subtype)
                    decoder.decode_iterator(ScyllaCollectionIterator.new(scylla_value)).to_a
                end
            end

            class SetDecoder < BaseDecoder
                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeSet]
                end

                def decode_with_type(scylla_value)
                    subtype = LibScylla.value_primary_sub_type(scylla_value)
                    decoder = BaseDecoder.get_decoder(subtype)
                    decoder.decode_iterator(ScyllaCollectionIterator.new(scylla_value)).to_set
                end
            end

            class MapDecoder < BaseDecoder
                private module ScyllaMapIterator
                    include Iterator(LibScylla::ScyllaValue)

                    def initialize(scylla_value : LibScylla::ScyllaValue)
                        @scylla_iterator = LibScylla.iterator_from_map(scylla_value)
                    end

                    def finalize
                        LibScylla.iterator_free(@scylla_iterator)
                    end

                    def next
                        if LibScylla.iterator_next(@scylla_iterator) == LibScylla::BoolT::True
                            parse_val(@scylla_iterator)
                        else
                            stop
                        end
                    end
                end

                private class ScyllaMapKeyIterator
                    include ScyllaMapIterator

                    def parse_val(scylla_iterator)
                        LibScylla.iterator_get_map_key(scylla_iterator)
                    end
                end 

                private class ScyllaMapValueIterator
                    include ScyllaMapIterator
                
                    def parse_val(scylla_iterator)
                        LibScylla.iterator_get_map_value(scylla_iterator)
                    end
                end

                def self.scylla_value_codes
                    [LibScylla::ScyllaValueType::ValueTypeMap]
                end

                def decode_with_type(scylla_value)
                    key_type = LibScylla.value_primary_sub_type(scylla_value)
                    key_decoder = BaseDecoder.get_decoder(key_type)
                    keys = key_decoder.decode_iterator(ScyllaMapKeyIterator.new(scylla_value))

                    val_type = LibScylla.value_secondary_sub_type(scylla_value)
                    val_decoder = BaseDecoder.get_decoder(val_type)
                    vals = val_decoder.decode_iterator(ScyllaMapValueIterator.new(scylla_value))
                    
                    count_of_items = LibScylla.value_item_count(scylla_value)
                    hsh = Hash(Any, Any).new(block: nil, initial_capacity: count_of_items)
                    keys.zip(vals).each do |(key, val)|
                        hsh[key] = val
                    end

                    hsh
                end
            end
        end
    end
end