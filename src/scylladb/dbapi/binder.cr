require "db"

module ScylladB
    module DBApi
        class ValueBinder
            class BindError < DB::Error
            end

            def initialize(@scylla_stmt : LibScylla::ScyllaStatement, @i : Int32)
            end

            def bind(any)
                scylla_error = do_bind(any)

                if scylla_error != LibScylla::ScyllaError::Ok
                    val_s = any.inspect
                    val_s = "#{val_s[0..1000]}..." if val_s.size > 1500
                    raise BindError.new("#{scylla_error}: passed\n#{val_s}\n" \
                                        "of type #{typeof(any)} at index #{@i}")
                end
            end

            private def do_bind(val : Any)
                do_bind(val.raw)
            end

            private def do_bind(val : Nil)
                LibScylla.statement_bind_null(@scylla_stmt, @i)
            end

            private def do_bind(val : Bool)
                scylla_value = val ? LibScylla::BoolT::True : LibScylla::BoolT::False
                LibScylla.statement_bind_bool(@scylla_coll, @i, scylla_value)
            end

            private def do_bind(val : Float32)
                LibScylla.statement_bind_float(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Float64)
                LibScylla.statement_bind_double(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Int8)
                LibScylla.statement_bind_int8(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Int16)
                LibScylla.statement_bind_int16(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Int32)
                LibScylla.statement_bind_int32(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Int64)
                LibScylla.statement_bind_int64(@scylla_stmt, @i, val)
            end

            private def do_bind(val : Bytes)
                LibScylla.statement_bind_bytes(@scylla_stmt, @i, val, val.size)
            end

            private def do_bind(val : String)
                LibScylla.statement_bind_string_n(@scylla_stmt, @i, val, val.bytesize)
            end

            private def do_bind(val : DBApi::Date)
                LibScylla.statement_bind_uint32(@scylla_stmt, @i, val.days)
            end

            private def do_bind(val : DBApi::Time)
                LibScylla.statement_bind_int64(@scylla_stmt, @i, val.total_nanoseconds)
            end

            private def do_bind(val : ::Time)
                ms = (val - EPOCH_START).total_miliseconds.to_i64
                LibScylla.statement_bind_int64(@scylla_stmt, @i, ms)
            end

            private def do_bind(val : DBApi::Uuid | DBApi::TimeUuid)
                LibScylla.statement_bind_uuid(@scylla_stmt, @i, val)
            end

            private def do_bind(vals : Array)
                scylla_colletion = LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeList,
                    vals.size
                )

                begin
                    vals.each { |val| append(scylla_colletion, val) }
                    LibScylla.statement_bind_collection(@scylla_stmt, @i, scylla_colletion)
                ensure
                    LibScylla.collection_free(scylla_colletion)                    
                end
            end

            private def do_bind(vals : Set)
                scylla_colletion = LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeSet,
                    vals.size
                )

                begin
                    vals.each { |val| append(scylla_colletion, val) }
                    LibScylla.statement_bind_collection(@scylla_stmt, @i, scylla_colletion)
                ensure
                    LibScylla.collection_free(scylla_colletion)                    
                end
            end

            private def do_bind(vals : Hash(Any, Any))
                scylla_map= LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeMap,
                    vals.size
                )

                begin
                    vals.each { |entry| entry.each { |v| append(scylla_map, v.raw) } }
                    LibScylla.statement_bind_collection(@scylla_stmt, @i, scylla_map)
                ensure
                    LibScylla.collection_free(scylla_map)                    
                end
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Nil)
                raise BindError.new("ScyllaDB does not support nulls in collections.")
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Bool)
                scylla_value = val ? LibScylla::BoolT::True : LibScylla::BoolT::False
                LibScylla.collection_append_bool(scylla_coll, scylla_value)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int8)
                LibScylla.collection_append_int8(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int16)
                LibScylla.collection_append_int16(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int32)
                LibScylla.collection_append_int32(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int64)
                LibScylla.collection_append_int64(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Float32)
                LibScylla.collection_append_int32(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Float64)
                LibScylla.collection_append_int64(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Bytes)
                raise NotImplementedError.new("Not implemented")
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : String)
                LibScylla.collection_append_string_n(scylla_coll, val, val.size)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Date)
                LibScylla.collection_append_uint32(scylla_coll, val.days)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : ::Time)
                ms = (val - EPOCH_START).total_miliseconds.to_i64
                LibScylla.collection_append_int64(scylla_coll, ms)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Time)
                LibScylla.collection_append_int64(scylla_coll, val.total_nanoseconds)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Uuid | DBApi::TimeUuid)
                LibScylla.collection_append_uuid(scylla_coll, val)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Array)
                scylla_list = LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeList,
                    vals.size
                )

                begin
                    vals.each { |item| append(scylla_list, item) }
                    LibScylla.collection_append_collection(scylla_coll, scylla_list)
                ensure
                    LibScylla.collection_free(scylla_list)
                end
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Set)
                scylla_set = LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeSet,
                    vals.size
                )

                begin
                    vals.each { |item| append(scylla_set, item) }
                    LibScylla.collection_append_collection(scylla_coll, scylla_set)
                ensure
                    LibScylla.collection_free(scylla_set)
                end
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Hash(Any, Any))
                scylla_map = LibScylla.collection_new(
                    LibScylla::ScyllaCollectionType::CollectionTypeMap,
                    vals.size
                )
                
                begin
                    vals.each { |entry| entry.each { |v| append(scylla_map, v.raw) } }
                    LibScylla.collection_append_collection(scylla_coll, scylla_map)
                ensure
                    LibScylla.collection_free(scylla_map)
                end
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, any : Any)
                append(scylla_coll, any.raw)
            end
        end
    end
end